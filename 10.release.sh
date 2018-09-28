#!/bin/sh

. ./00.config.sh

echo "===> Making directories..."
mkdir -p "${SRC_DIR}" "${RELEASE_DIR}"


echo "===> Getting script version..."
SCRIPT="${SRC_DIR}/${EXT_FILE_NAME}"
if [ ! -f "${SCRIPT}" ]; then
	echo "Error reading script: ${SCRIPT}"
	exit 1
fi
VERSION=$(cat "${SCRIPT}" | grep "// @version" | head -1 | awk '{print $3}')
if [ -z "${VERSION}" ]; then
	echo "Error getting script version"
	exit 1
fi
echo "\tversion ${VERSION}"

echo "===> Getting GreasyFork script version..."
SCRIPT_GF="${SCRIPT%%.user.js}.gf.js"
if [ ! -f "${SCRIPT_GF}" ]; then
	echo "Error reading script: ${SCRIPT_GF}"
	exit 1
fi
VERSION_GF=$(cat "${SCRIPT_GF}" | grep "// @version" | head -1 | awk '{print $3}')
if [ -z "${VERSION_GF}" ]; then
	echo "Error getting script version"
	exit 1
fi
echo "\tversion ${VERSION}"
if [ "${VERSION}" != "${VERSION_GF}" ]; then
	echo "Error matching script versions: ${VERSION} != ${VERSION_GF}"
	echo "Please update ${SCRIPT_GF}"
	exit 1
fi

echo "===> Updating manifest version..."
MANIFEST_FILE="chrome/manifest.json"
if [ ! -f "${MANIFEST_FILE}" ]; then
	echo "Error reading manifest file: ${MANIFEST_FILE}"
	exit 1
fi
sed -i.bak -E \
	-e "s/(\"version\":.+\".+\")/\"version\": \"${VERSION}\"/" \
	"${MANIFEST_FILE}"


RELEASE_FILE="${RELEASE_DIR}/${EXT_NAME}.${VERSION}.user.js"
echo "===> Creating ${RELEASE_FILE}..."
cp "${SCRIPT}" "${RELEASE_FILE}"

RELEASE_GF_FILE="${RELEASE_DIR}/${EXT_NAME}.${VERSION}.gf.js"
echo "===> Creating ${RELEASE_GF_FILE}..."
cp "${SCRIPT_GF}" "${RELEASE_GF_FILE}"


ZIP_FILE="${RELEASE_DIR}/${EXT_NAME}.${VERSION}.zip"
echo "===> Creating ${ZIP_FILE}..."
rm -f "${ZIP_FILE}"
zip --junk-paths "${ZIP_FILE}" \
	img/WV-icon128.png \
	img/WV-icon16.png \
	img/WV-icon48.png \
	${SCRIPT} \
	chrome/bootstrap.user.js \
	priv/key.pem \
	chrome/manifest.json


USER_FILE="${RELEASE_DIR}/${EXT_FILE_NAME}"
echo "===> Creating ${USER_FILE}..."
ln -f "${RELEASE_FILE}" "${USER_FILE}"


META_FILE="${RELEASE_DIR}/${EXT_FILE_NAME%%.user.js}.meta.js"
echo "===> Creating ${META_FILE}..."
cat "${USER_FILE}" | head -30 | grep '^// ' > "${META_FILE}"

echo "===> Done."
