CXX = g++ -std=c++11
CXXFLAGS = -Wall -O -g -MMD

# src/main.cpp
CLI_OBJECT = src/main.o
CLI_DEPEND = src/main.d

# src/
SOURCE  = $(filter-out src/main.cpp, $(wildcard src/*.cpp)) $(wildcard src/nodes/*.cpp)
OBJECTS = ${SOURCE:.cpp=.o}
DEPENDS = ${OBJECTS:.o=.d}

# test/
TEST_SOURCE  = $(wildcard test/*.cpp)
TEST_OBJECTS = ${TEST_SOURCE:.cpp=.o}
TEST_DEPENDS = ${TEST_OBJECTS:.o=.d}

EXEC = emerald
TEST_EXEC = emerald_test
LIBS = -lboost_regex

${EXEC} : ${CLI_OBJECT} ${OBJECTS}
	${CXX} ${CXXFLAGS} ${CLI_OBJECT} ${OBJECTS} -o ${EXEC} ${LIBS}

${TEST_EXEC}: ${OBJECTS} ${TEST_OBJECTS}
	${CXX} ${CXXFLAGS} ${OBJECTS} ${TEST_OBJECTS} -o ${TEST_EXEC} ${LIBS}

test: ${TEST_EXEC}
	./${TEST_EXEC}

clean:
	rm ${CLI_DEPEND} ${DEPENDS} ${TEST_DEPENDS} ${CLI_OBJECT} ${OBJECTS} ${TEST_OBJECTS} $(EXEC) ${TEST_EXEC}

-include {DEPENDS} {TEST_DEPENDS}
