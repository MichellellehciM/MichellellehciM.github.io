---
title: Python 字串格式化入門：從 `%` 到 `f-string` 一次搞懂
description: 本篇帶你用簡單範例學會 Python 的三種常見字串格式化方式，包含舊式 `%` 格式、新式 `.format()`，以及 Python 3.6 之後最推薦的 f-string。
slug: python-fstring
date: 2024-11-29 10:00:00+0000
image: python_f-string.png
categories:
  - Python
  - 程式設計
tags:
  - Python基礎
  - 字串
  - 格式化
  - f-string
weight:
---

# Python 字串格式化入門教學

你是否曾經遇到要在 `print()` 中顯示變數內容，但不知道該怎麼優雅地寫出整齊又清楚的訊息？

本篇將帶你一步一步認識 Python 的 **三種字串格式化方式**：

((第1和第2種可以看過稍微了解概念就好，覺得麻煩的話可以直接看第3點的 f-string XD))

1. `%` 格式化 (舊式)  
2. `str.format()` 格式化 (新式)   
3. Python 3.6+ 的 `f-string`（最推薦!!新手請直接學）

---

## 1️⃣ 舊式格式化：`%` 操作符

這是 Python 最早期的格式化方式，很像 C 語言中的 `printf`。

```python
name = 'World'
x = 100
y = 3.1415

print('hi %s' % name)              # hi Wolrd
print('hi %d' % x)                 # hi 100
print('hi %f' % y)                 # hi 3.141500
print('hi %s, my number is %d' % (name, x))  # hi World, my number is 100
```

### ✅ 格式說明：
| 符號 | 代表意思     | 範例       |
|------|--------------|------------|
| `%s` | 字串         | `'World'`  |
| `%d` | 整數（decimal）| `100`       |
| `%f` | 浮點數        | `3.14`     |

你也可以控制小數點位數：
```python
print('pi = %.2f' % 3.14159)  # pi = 3.14
```

---

## 2️⃣ `str.format()` 方法（新式）

這種寫法較有彈性，也更容易閱讀和管理。

```python
print('hi {}, my number is {}'.format(name, x))  
# hi World, my number is 100
```

也可以加入欄位索引或變數名稱：

```python
print('hi {0}, my number is {1}'.format(name, x))
print('hi {name}, number: {num}'.format(name=name, num=x))
```

---

## 3️⃣ f-string（Python 3.6+ 最推薦）

f-string 是目前最推薦的格式化方式，**簡潔、直觀、可讀性高**。

```python
print(f'hi {name}, my number is {x}')  # hi World, my number is 100
print(f'y = {y:.2f}')                  # y = 3.14
```

---

### f-string 補充：對齊與寬度設定

你可以使用 f-string 的語法來控制欄位的寬度與對齊方式。

```python
name = "World"
x = 100

# 將 name 往右對齊，寬度為 10 個字元
print(f'hi {name:>10}, my num is {x}')
```

輸出結果：

```
hi      World, my num is 100
```

### 對齊格式一覽：

| 語法         | 說明           |
|--------------|----------------|
| `:>10`       | 右對齊，寬度 10 |
| `:<10`       | 左對齊，寬度 10 |
| `:^10`       | 置中對齊，寬度 10 |
| `:*^10`      | 置中並用 `*` 補滿 |

```python
print(f'|{name:<10}|')   # |World     |
print(f'|{name:^10}|')   # |  World   |
print(f'|{name:*^10}|')  # |**World**|
```

---

## 三種格式化方式比較

| 類型       | 語法風格          | 可讀性 | 推薦程度 |
|------------|-------------------|--------|----------|
| 舊式 `%`   | `'hi %s' % name`   | 中     | ❌ 不推薦 |
| `.format()`| `'hi {}'.format()` | 中上   | ☑️ 可用   |
| f-string   | `f'hi {name}'`     | 高     | ✅✅✅✅✅ |

---

## 總結

| 如果你使用的是 Python 3.6+，強烈建議直接使用 **f-string**，簡單又強大！  
| 如果還在學舊專案或 C 語言背景的人，可以理解 `%` 是歷史包袱，但新專案建議避免使用。

---

## 小練習

試著完成以下程式碼，輸出你的名字與分數（保留小數點後 1 位）：

```python
name = '你的名字'
score = 97.567

# 請用 f-string 輸出：Hi, 我是 你的名字，我的成績是 97.6 分
```

---


