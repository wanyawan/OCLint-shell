source ~/.bash_profile

PROJECT_DIR=$(cd `dirname $0`;cd ..;pwd)

cd ${PROJECT_DIR}

compilecommandsFilePath="${PROJECT_DIR}/oclint/"

compilecommandsJsonFilePath="${PROJECT_DIR}/oclint/compile_commands.json"

reportFilePath="${PROJECT_DIR}/oclint/oclint_result.html"

xcodebuild clean

xcodebuild -workspace workspace.xcworkspace -configuration Debug -scheme scheme build | xcpretty -r json-compilation-database -o $compilecommandsJsonFilePath

cd $compilecommandsFilePath

oclint-json-compilation-database -e Pods --  -report-type html -o $reportFilePath \
-rc LONG_VARIABLE_NAME=30 \
-rc SHORT_VARIABLE_NAME=1 \
-rc MAXIMUM_IF_LENGTH=5 \
-rc MINIMUM_CASES_IN_SWITCH=2 \
-rc LONG_METHOD=80
-rc NCSS_METHOD=30 \
-rc LONG_LINE=180 \
-rc LONG_CLASS=1000 \
-rc TOO_MANY_PARAMETERS=10

#-max-priority-1 0 \
#-max-priority-2 5 \
#-max-priority-3 10
#-rc CYCLOMATIC_COMPLEXITY=10 \
#-rc NESTED_BLOCK_DEPTH=5 \
#-rc TOO_MANY_METHOD=30 \
