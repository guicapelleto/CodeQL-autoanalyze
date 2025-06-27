#!/bin/bash
#by guicapelleto

project=$1
lang=$2

echo ""
echo "##################################"
echo "########CodeQL autoanalyze########"
echo "##################################"
echo ""
echo ""

if [ "$project" == "" ] || [ "$project" == "-h" ] || [ "$project" == "--help" ] || [ "$lang" == "-h" ] || [ "$lang" == "--help" ] || [ "$lang" == "" ]
then
    echo "Usage:"
    echo "$0 [PROJECT_FOLDER] [LANGUAGE] "
    echo ""
    echo ""
    echo "Supported languages:"
    echo "C"
    echo "C++"
    echo "C#"
    echo "Python"
    echo "Go Lang"
    echo "Java"
    echo "Javascript"
    echo "Ruby"
    echo "Swift"
    echo ""
    echo ""
    echo "CodeQL must be installed, if it's not, please check at: https://github.com/github/codeql-action/releases"
    echo "Make sure your PATH Environment is up to date with codeql"
    echo ""
    echo "Ex: $0 /tmp/mytmpproj/js javascript"
    echo ""
    echo ""
    exit
fi



echo "Building database..."
codeql database create codeql-db --language=$lang --source-root=$project/.
echo ""
echo ""
echo "Checking latest queries..."
codeql pack download codeql/$lang-queries
echo ""
echo ""
echo "Analyzing..."
codeql database analyze codeql-db codeql/$lang-queries --format=sarifv2.1.0 --output=codeql-results.sarif
echo ""
echo ""
echo ""s
echo "Check the file >>> codeql-results.sarif <<<"