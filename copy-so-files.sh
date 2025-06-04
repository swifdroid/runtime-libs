#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

ARCHS=(
    "arm64-v8a"
    "armeabi-v7a"
    "x86_64"
)

SUBMODULES=(
    "compression"
    "core"
    "foundation"
    "foundationessentials"
    "i18n"
    "networking"
    "testing"
    "xml"
)

get_arch_path() {
    case "$1" in
        arm64-v8a) echo "aarch64-linux-android" ;;
        armeabi-v7a) echo "arm-linux-androideabi" ;;
        x86_64) echo "x86_64-linux-android" ;;
        *) return 1 ;;
    esac
}

get_so_files_for_submodule() {
    case "$1" in
        compression) echo "liblzma.so libz.so" ;;
        core) echo "libandroid-execinfo.so libandroid-spawn.so libc++_shared.so libcharset.so libswift_Builtin_float.so libswift_Concurrency.so libswift_Differentiation.so libswift_math.so libswift_RegexParser.so libswift_StringProcessing.so libswift_Volatile.so libswiftAndroid.so libswiftCore.so libswiftDistributed.so libswiftObservation.so libswiftRegexBuilder.so libswiftSwiftOnoneSupport.so libswiftSynchronization.so" ;;
        foundation) echo "lib_FoundationICU.so libBlocksRuntime.so libdispatch.so libFoundation.so libiconv.so libswiftDispatch.so" ;;
        foundationessentials) echo "libFoundationEssentials.so" ;;
        i18n) echo "libFoundationInternationalization.so" ;;
        networking) echo "libcrypto.so libcurl.so libFoundationNetworking.so libnghttp2.so libnghttp3.so libssh2.so libssl.so" ;;
        testing) echo "libTesting.so libXCTest.so" ;;
        xml) echo "libFoundationXML.so libxml2.so" ;;
        *) return 1 ;;
    esac
}

set -euo pipefail

# ────────────────────────────────────────────────────────────────────────────────
# ARGUMENT PARSING
# ────────────────────────────────────────────────────────────────────────────────
KEEP=false
DRY=false
POSITIONAL=()

for arg in "$@"; do
    case $arg in
        --keep)
            KEEP=true
            shift
            ;;
        --dry)
            DRY=true
            shift
            ;;
        -*)
            echo -e "${RED}❌ Unknown flag: $arg${NC}"
            exit 1
            ;;
        *)
            POSITIONAL+=("$arg")
            ;;
    esac
done

if [ ${#POSITIONAL[@]} -ne 1 ]; then
    echo -e "${RED}❌ Error: Missing or invalid arguments.${NC}"
    echo
    echo -e "${YELLOW}Usage:${NC} $0 ${BLUE}[--keep] [--dry] <path-to-archive | extracted-folder | download-url>${NC}"
    echo
    echo -e "${GREEN}Options:${NC}"
    echo -e "  ${BLUE}--keep${NC}    Keep downloaded archive and extracted folder after processing"
    echo -e "  ${BLUE}--dry${NC}     Dry run — show what would happen without actually copying files"
    echo
    echo -e "${GREEN}Examples:${NC}"
    echo -e "  ${BLUE}./copy-so-files.sh swift-*.tar.gz${NC}"
    echo -e "  ${BLUE}./copy-so-files.sh --keep swift-*.tar.gz${NC}"
    echo -e "  ${BLUE}./copy-so-files.sh --dry https://...tar.gz${NC}"
    echo -e "  ${BLUE}./copy-so-files.sh --keep --dry /path/to/.artifactbundle${NC}"
    echo
    exit 1
fi

INPUT="${POSITIONAL[0]}"
CWD="$(pwd)"
NEEDS_CLEANUP=false
DOWNLOADED_ARCHIVE=""

# ────────────────────────────────────────────────────────────────────────────────
# DOWNLOAD FROM URL
# ────────────────────────────────────────────────────────────────────────────────
if [[ "$INPUT" == http* ]]; then
    echo -e "${BLUE}🌐 Downloading SDK archive from:${NC} $INPUT"

    if command -v curl &> /dev/null; then
        DOWNLOADER="curl -L -o"
    elif command -v wget &> /dev/null; then
        DOWNLOADER="wget -O"
    else
        echo -e "${RED}❌ Error: Neither curl nor wget found.${NC}"
        exit 1
    fi

    ARCHIVE_NAME=$(basename "$INPUT")
    ARCHIVE_PATH="./$ARCHIVE_NAME"

    echo -e "${BLUE}⬇️  Saving to:${NC} $ARCHIVE_PATH"
    $DOWNLOADER "$ARCHIVE_PATH" "$INPUT"

    INPUT="$ARCHIVE_PATH"
    NEEDS_CLEANUP=true
    DOWNLOADED_ARCHIVE="$ARCHIVE_PATH"
fi

# ────────────────────────────────────────────────────────────────────────────────
# EXTRACT IF ARCHIVE
# ────────────────────────────────────────────────────────────────────────────────
if [[ "$INPUT" == *.tar.gz ]]; then
    if [ ! -f "$INPUT" ]; then
        echo -e "${RED}❌ Error: Archive not found:${NC} $INPUT"
        exit 1
    fi

    echo -e "${BLUE}📦 Extracting archive to:${NC} ./artifactbundle"
    rm -rf ./artifactbundle 2>/dev/null || true
    mkdir -p ./artifactbundle

    tar -xzf "$INPUT" -C ./artifactbundle --strip-components=0
    NEEDS_CLEANUP=true

    ARTIFACT_BUNDLE_PATH=$(find ./artifactbundle -maxdepth 1 -type d -name "*.artifactbundle" | head -n 1)
    if [ -z "$ARTIFACT_BUNDLE_PATH" ]; then
        echo -e "${RED}❌ Error: No .artifactbundle directory found after extraction.${NC}"
        rm -rf ./artifactbundle
        [ -n "$DOWNLOADED_ARCHIVE" ] && rm -f "$DOWNLOADED_ARCHIVE"
        exit 1
    fi
else
    ARTIFACT_BUNDLE_PATH="$INPUT"
    if [ ! -d "$ARTIFACT_BUNDLE_PATH" ]; then
        echo -e "${RED}❌ Error: Directory not found:${NC} $ARTIFACT_BUNDLE_PATH"
        exit 1
    fi
fi

# ────────────────────────────────────────────────────────────────────────────────
# AUTODETECT SDK/SYSROOT
# ────────────────────────────────────────────────────────────────────────────────

SDK_FOLDER=$(find "$ARTIFACT_BUNDLE_PATH" -maxdepth 1 -type d -name "swift-*-sdk" | head -n 1)
if [ -z "$SDK_FOLDER" ]; then
    echo -e "${RED}❌ Error: SDK folder not found inside:${NC} $ARTIFACT_BUNDLE_PATH"
    $NEEDS_CLEANUP && rm -rf ./artifactbundle
    exit 1
fi

SYSROOT_FOLDER=$(find "$SDK_FOLDER" -maxdepth 1 -type d -name "android-*-sysroot" | head -n 1)
if [ -z "$SYSROOT_FOLDER" ]; then
    echo -e "${RED}❌ Error: sysroot folder not found inside SDK.${NC}"
    $NEEDS_CLEANUP && rm -rf ./artifactbundle
    exit 1
fi

ACTUAL_SOURCE="$SYSROOT_FOLDER/usr/lib"

# ────────────────────────────────────────────────────────────────────────────────
# COPY LOGIC
# ────────────────────────────────────────────────────────────────────────────────

echo
echo -e "${BLUE}📁 Artifact bundle path:        ${NC}$ARTIFACT_BUNDLE_PATH"
echo -e "${BLUE}📂 Auto-detected SDK folder:    ${NC}$SDK_FOLDER"
echo -e "${BLUE}📂 Auto-detected sysroot folder:${NC}$SYSROOT_FOLDER"
echo -e "${BLUE}📦 Destination project root:    ${NC}$CWD"
echo

for submodule in "${SUBMODULES[@]}"; do
    [ "$DRY" = true ] && echo -e "📦 ${BLUE}SUBMODULE: ${submodule}"
    so_files=$(get_so_files_for_submodule "$submodule") || continue

    for arch in "${ARCHS[@]}"; do
        [ "$DRY" = true ] && echo -e "    🎈 ${BLUE}ARCH: ${arch}"
        arch_path=$(get_arch_path "$arch") || continue

        jni_dir="$CWD/$submodule/src/main/jniLibs/$arch"
        mkdir -p "$jni_dir"

        for so in $so_files; do
            [ "$DRY" = true ] && echo -e "        🔖 ${BLUE}SO: ${so}"

            src_file="$ACTUAL_SOURCE/$arch_path/$so"
            dest_file="$jni_dir/$so"

            if [ ! -f "$src_file" ]; then
                if [ "$DRY" = true ]; then
                    echo -e "        ${YELLOW}⚠️  Missing: ${NC}$src_file"
                else
                    echo -e "${YELLOW}⚠️  Missing: ${NC}$src_file"
                fi
                continue
            fi

            if [ "$DRY" = true ]; then
                echo "                |- $src_file"
                echo "                -> $dest_file"
            else
                cp -f "$src_file" "$dest_file"
                echo -e "${GREEN}✅ Copied:${NC} $so → $submodule [$arch]"
            fi
        done
    done
done

# ────────────────────────────────────────────────────────────────────────────────
# CLEANUP
# ────────────────────────────────────────────────────────────────────────────────

if $NEEDS_CLEANUP && ! $KEEP; then
    echo
    echo -e "${BLUE}🧹 Cleaning up downloaded archive and ./artifactbundle folder...${NC}"
    [ -n "$DOWNLOADED_ARCHIVE" ] && rm -f "$DOWNLOADED_ARCHIVE"
    rm -rf ./artifactbundle
fi

echo
if [ "$DRY" = true ]; then
    echo -e "${GREEN}🎉 Done! This was a dry run — no files were copied. The output above shows what would have happened.${NC}"
else
    echo -e "${GREEN}🎉 Done! All available .so files have been copied.${NC}"
fi
