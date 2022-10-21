# 1. соответствие переменных адресам стека
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

# 2. Использование программы и общая информация
Программа состоит из 2-х единиц компиляции. 1-ая единица это main, вторая countArrayB. 
У программы есть 3 режима работы через консоль
1) ./answer.exe     - это запуск без параметров argv[1] и тогда будет ввод и вывод в консоль
2) ./answer.exe 1   - argv[1] = 1 тогда будут данные браться из файла input.txt и класться в output.txt
3) ./answer.exe 2   - argv[1] = 2 рандомный ввод и вывод в консоль


# 3. рефакторниг
1) удалил бесполезную часть с конца файла
2) убрал бесполезную работу когда сначала кладут в rax потом в rsi из rax, я стал класть сразу в rax
3) во время больших циклов клал i в регистры вместо того чтобы каждый раз дергать из стека
так как длина нашего массива до 10 то при вводе и выводе я не клал i в регистр, потому что это бессмысленно, это сэкономит почти ничего. А в самой функции countArrayB я положил j в регистр а также в цикле вокруг функции я стал использовать регистры 
r14d = length  (-52[rbp] in main)
r15d = i.       (-4[rbp] in main)
rbx = j         (-4[rbp] in countArrayB)
r13d = length   (-20[rbp] in countArrayB)
это улучшило производительность в 2 раза примерно. То есть я использовал регистры вместо обращения к стеку как нужндо для 6 баллов.
4) убрал бесполезные строки когда в регистр записывается значение которое там уже было и не могло измениться
5) оптимизировал цикл вычисление массива B. Там дважды брали значение из стека одно и тоже (значение из массива А). я сделал так что берем один раз и сохраняем в регистры. Это улучшило производительность в 1.5 раза примерно. Более подробно можете посмотреть в исходном s файле и после моего рефакторинга.


# 4. тестовые прогоны
Результаты всех тестовых данных (в папке tests) дают одинаковые результаты на деволтной(неотрефракторенной) программе и моей.
В программе есть функция засекания времени. И как можно увидеть на тестовых данных моя программа быстрее деволтной примерно в 3 раза. Это было достигнута благодаря замене переменных со стека на регистры.
