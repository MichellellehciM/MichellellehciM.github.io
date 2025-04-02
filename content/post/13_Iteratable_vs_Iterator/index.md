---
title: Python 可迭代 (Iteratable) 與 迭代器 (Iterator) 入門
description: 本篇帶你用簡單方式理解 Python 的迭代機制，包含什麼是可迭代物件（iterable）與迭代器（iterator），以及新手常見問題。
slug: python-iterator
date: 2024-11-30 10:00:00+0000
image: python_iterator.png
categories:
  - Python
  - 程式設計
tags:
  - Python基礎
  - 迴圈
  - 可迭代物件
  - 迭代器
weight:
---

# 什麼是迭代 (Iteration)? Python 新手必看的入門教學

想了解 Python 的 for 迴圈是怎麼運作的嗎？

這篇文章將帶你從最基礎開始，一步步搞懂 Python 中的 迭代（Iteration），以及你一定會看到的兩個角色：可迭代物件（iterable） 和 迭代器（iterator）。


## 什麼是迭代（Iteration）

迭代，是按照順序一個一個取出資料的過程。

例如：

```python
for i in "Michelle":
    print(i)
```

會印出：

M
i
c
h
e
l
l
e


## 什麼是可迭代物件（iterable）

可迭代物件是指「可以被 for 迴圈處理」的資料。也就是說，裡面的元素可以被一個一個取出來。

以下是幾種常見的可迭代物件，每種都附上一個例子：

- 字串（string）

  ```python
  for i in "hello":
      print(i)
  ```

- 清單（list）

  ```python
  for i in [1, 2, 3]:
      print(i)
  ```

- 元組（tuple）

  ```python
  for i in (4, 5, 6):
      print(i)
  ```

- 字典（dict）

  ```python
  for key in {"a": 1, "b": 2}:
      print(key)
  ```

- 集合（set）

  ```python
  for i in {7, 8, 9}:
      print(i)
  ```

- range 物件

  ```python
  for i in range(3):
      print(i)
  ```


## 什麼是迭代器（iterator）

迭代器是真正執行「逐一取值」動作的東西，它會記住目前走到哪裡。

可以用內建函式 `iter()` 將一個可迭代物件變成迭代器：

```python
x = [1, 2, 3]
it = iter(x)
```

接著用 `next()` 一個一個取值：

```python
print(next(it))  # 1
print(next(it))  # 2
print(next(it))  # 3
print(next(it))  # 會發生 StopIteration 錯誤
```

說明：
- 迭代器有記憶功能，知道自己目前位置
- 走過的內容不能回頭，只能從頭到尾走一遍


## 迭代只能走一次

這是新手最容易忽略的地方

```python
x = [1, 2, 3]
it = iter(x)

print(list(it))  # [1, 2, 3]
print(list(it))  # []
```

因為 `it` 是迭代器，已經走完了，後面就沒有資料可以用了。

同樣地：

```python
x = [1, 2, 3]
it = iter(x)

print(sum(it))  # 6
print(sum(it))  # 0
```


## range(0) 是空的迭代

```python
for i in range(0):
    print("hi")
```

不會印出任何東西，因為 range 裡沒有任何數字。


## 新手常見問題整理

### 1. 為什麼 list(it) 第二次是空的？

因為迭代器只能走一次，已經被取光了。要重新取值就要重新呼叫 iter。


### 2. 我可以直接對 list 用 next() 嗎？

不行，list 本身不是迭代器，要先用 iter(list) 才能用 next。


### 3. 什麼時候需要自己用 iter() 和 next()？

當你需要更細緻地控制資料的讀取過程，例如寫 parser、處理大型檔案、觀察迭代行為時。


### 4. 什麼時候會使用 iterator？

當你需要逐步取出資料並保持當前狀態時會用到 iterator，例如你想中斷再繼續迭代、或要自己控制流程時。


### 5. 可迭代物件和迭代器有什麼不同？

- 可迭代物件是「可以被疊代的資料容器」，但本身不能用 next 取值
- 迭代器是用 iter() 從可迭代物件產生的物件，才可以用 next()


## 小挑戰：這段程式會輸出什麼？

```python
x = [10, 20, 30]
it = iter(x)

print(next(it))
print(sum(it))
```

正確答案是：

10
50

說明：
- 第一次 next(it) 取出 10
- 剩下的是 [20, 30]，所以 sum(it) 為 50

你答對了嗎？

