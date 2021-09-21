OUTPUT_DIR=$1
REPOSITORY_URL=$2
RELEASE=$3

echo "output dir: $OUTPUT_DIR"
echo "repository url: $REPOSITORY_URL"

mkdir -p $OUTPUT_DIR

OLDIFS=$IFS
IFS='/'
read -a strarr <<< $REPOSITORY_URL
OWNER_NAME=${strarr[-2]}
PROJECT_NAME=${strarr[-1]}
IFS=$OLDIFS
echo "Deduced project name: $PROJECT_NAME"

if [[ -z ${RELEASE+z} ]];
then
  LAST_RELEASE=`git tag | tail -1`;
  if [ -z "$LAST_RELEASE" ]; then LAST_RELEASE="main"; fi;
  echo "Last release is $LAST_RELEASE";
fi;

ARCHIVE="$PROJECT_NAME-$LAST_RELEASE.zip"
wget -O $ARCHIVE $REPOSITORY_URL/archive/$LAST_RELEASE.zip
ls .
mv $ARCHIVE $OUTPUT_DIR

if test -f codemeta.json; then echo "adding codemeta.json file to $OUTPUT_DIR"; cp codemeta.json $OUTPUT_DIR; else echo "no codemeta.json file to add"; fi;


echo "Content of $OUTPUT_DIR :"
ls -lsh $OUTPUT_DIR
