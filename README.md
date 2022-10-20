# соответствие переменных адресам стека
1) -68[pbp] = argc
2) -72[rbp] = argv[1]
3) -80[rbp] = argv[0]
4) -52[rbp] = length
5) -4[rbp] = i
6) -16[rbp] = input
7) -24[rbp] = start
8) -32[rbp] = end
9) -40[rbp] = time_spent
10) -48[rbp] = output



# рефакторниг
1) удалил бесполезную часть с конца файла
2) убрал бесполезную работу когда сначала кладут в rax потом в rsi из rax, я стал класть сразу в rax
3) во время больших циклов клал i в регистры вместо того чтобы каждый раз дергать из стека
так как длина нашего массива до 10 то при вводе и выводе я не клал i в регистр, потому что это бессмысленно, это сэкономит почти ничего. А в самой функции countArrayB я положил j в регистр а также в цикле вокруг функции я стал использовать регистры 
r14d = length  (-52[rbp] in main)
r15d = i.       (-4[rbp] in main)
rbx = j         (-4[rbp] in countArrayB)
r13d = length   (-20[rbp] in countArrayB)
это улучшило производительность в 2 раза примерно.
эти замены дают значительный прирост в производительности. Добавление других регистров в других циклах не дает ничего
4) убрал бесполезные строки когда в регистр записывается значение которое там уже было и не могло измениться
5) оптимизировал цикл вычисление массива B. Там дважды брали значение из стека одно и тоже (значение из массива А). я сделал так что берем один раз и сохраняем в регистры. Это улучшило производительность в 1.5 раза примерно. Более подробно можете посмотреть в исходном s файле и после моего рефакторинга.
