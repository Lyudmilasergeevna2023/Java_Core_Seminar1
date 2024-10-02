FROM bellsoft/liberica-openjdk-alpine:11

# Копируем исходный код из папки src проекта внутрь образа:
COPY ./src /usr/app/src

# Создаем директории для выходных файлов и документации:
RUN mkdir -p /usr/app/ourclasses /usr/app/mydocumentation

# Компилируем исходный код и создаем javadoc
RUN javac -d /usr/app/ourclasses -sourcepath /usr/app/src /usr/app/src/ru/gb/safronov/Main.java && javadoc -d /usr/app/mydocumentation /usr/app/src/ru/gb/safronov/Main.java

# Устанавливаем рабочую директорию
WORKDIR /usr/app

# Запускаем Java приложение и открываем страницу javadoc в браузере:
CMD ["sh", "-c", "java -classpath /usr/app/ourclasses ru.gb.safronov.Main && cat /usr/app/mydocumentation/index-all.html"]
