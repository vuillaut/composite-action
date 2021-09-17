OUTPUT_DIR=$1
mkdir -p $OUTPUT_DIR
read -a strarr <<< $GITHUB_REPOSITORY
GITHUB_ORG=${strarr[0]}
PROJECT_NAME=${strarr[1]}
REPOSITORY_BASE_URL=$GITHUB_SERVER_URL/$GITHUB_REPOSITORY
LAST_RELEASE=`git tag | tail -1`
if [ -z "$LAST_RELEASE" ]; then LAST_RELEASE="master"; fi;
echo "Last release is $LAST_RELEASE"
ARCHIVE="$PROJECT_NAME-$LAST_RELEASE.zip"
wget -O $ARCHIVE $REPOSITORY_BASE_URL/archive/$LAST_RELEASE.zip
mv $ARCHIVE $OUTPUT_DIR
if test -f codemeta.json; then echo "adding codemeta.json file to $OUTPUT_DIR"; cp codemeta.json $OUTPUT_DIR; fi;
echo "Content of $OUTPUT_DIR:"
ls $OUTPUT_DIR
