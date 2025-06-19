#!/bin/bash
#by guicapelleto

lang=$1

echo ""
echo "##################################"
echo "########CodeQL autoanalyze########"
echo "##################################"
echo ""
echo ""

if [ "$lang" == "" ] || [ "$lang" == "-h" ] || [ "$lang" == "--help" ]
then
    echo "Usage:"
    echo "$0 [LANGUAGE] "
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
    echo "You must be at project root folder"
    echo "CodeQL must be installed, if it's not, please check at: https://github.com/github/codeql-action/releases"
    echo "Make sure your PATH Environment is up to date with codeql"
    echo ""
    echo ""
    exit
fi



echo "Building database..."
codeql database create codeql-db --language=$lang --source-root=.
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