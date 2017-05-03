CXX = g++ -std=c++14
CXXFLAGS = -Wall -O -g
OBJECTS = src/main.cpp src/grammar.cpp src/preprocessor.cpp
EXEC = emerald

${EXEC} : ${OBJECTS}
	${CXX} ${OBJECTS} ${CXXFLAGS} -o ${EXEC}

clean:
	rm $(EXEC)
