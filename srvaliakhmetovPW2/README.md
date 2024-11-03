#  Answers to questions

> What issues prevent us from using storyboards in real projects?

На основе опыта использования
1. Сложно работать в команде: конфликты при слиянии
2. Сложно дебажить
3. Декларативный подход (менее гибкий по сравнению с программной настройкой)
4. Проблемы с поддержкой нескольких версий IOS

> What does the code on lines 25 and 29 do?

```swift
title.translatesAutoresizingMaskIntoConstraints = false
```
Мы устаналиваем значение title.translatesAutoresizingMaskIntoConstraints в false (по дефолту = true). Это необходимо для возможности использования Auto Layout и добавления своих constraints.

```swift
view.addSubview(title)
```
Добавляем новое представление (все что наследуется от UIView) в view (отображение на экране)

> What is a safe area layout guide?

Буквально оно и есть.
Руководство по компоновке, представляющее ту часть представления, которая позволяет избежать дублирования элементов пользовательского интерфейса системы.

> What is [weak self] on line 23 and why it is important?

Мы создаем слабую ссылку, она может быть nil, это необходимо для корректного освобождения ресурсов. Сильная может помешать удалению из памяти, из-за того, что gc не может освободить ресурс, на который есть сильная ссылка.

> What does clipsToBounds mean?

со значением true:
Можно сказать, что это аналог overflow: hidden в css. Весь внутренний контент выходящий за границы родителя будет обрезаться по его границам.
со значением false: внутренний контент может выходить за границы дочерщнего элемента.

> What is the valueChanged type? What is Void and what is Double?

Это тип замыкания, принимающий одно значение типа Double (представление чисел с плавающей точкой) и возвращающий Void (Ничего) (похожим образом описывают функции в TypeScript). Тип функции.
