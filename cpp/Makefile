CXX = g++ -std=c++11
CXXFLAGS = -Wall -O -g
OBJECTS = src/grammar.cpp src/preprocessor.cpp src/htmlencode.cpp
CLI_OBJECTS = src/main.cpp
TESTS = $(wildcard test/*.cpp)
EXEC = emerald
TEST_EXEC = emerald_test
LIBS = -lboost_regex -I/usr/local/homebrew/Cellar/nlohmann_json/1.1.0/include

${EXEC} : ${CLI_OBJECTS} ${OBJECTS}
	${CXX} ${CLI_OBJECTS} ${OBJECTS} ${CXXFLAGS} -o ${EXEC} ${LIBS}

${TEST_EXEC}: ${OBJECTS} ${TESTS}
	${CXX} ${OBJECTS} ${TESTS} ${CXXFLAGS} -o ${TEST_EXEC} ${LIBS}

test: ${TEST_EXEC}
	./${TEST_EXEC}

clean:
	rm $(EXEC) ${TEST_EXEC}
