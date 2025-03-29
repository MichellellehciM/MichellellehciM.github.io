---
title: Python 註解與 Docstring 新手入門指南：寫出有說明的程式
description: 這篇文章帶你快速搞懂 Python 中的註解（comment）與說明文件（docstring），學會寫出更清楚易懂的程式碼。
slug: python-comment-docstring-guide
date: 2024-11-28 10:00:00+0000
image: python_comment_docstring.png
categories:
    - Python
    - 程式設計
tags:
    - Python基礎
    - docstring
    - 註解
    - 撰寫風格
    - 程式可讀性
weight:
---

# Python 註解與 Docstring 新手教學指南

在寫程式的過程中，「讓別人（包括未來的自己）看得懂」比你想得還重要！  
學會 **註解（comment）** 和 **說明文件（docstring）** 是寫出**可讀、可維護**程式碼的第一步。

---

## 什麼是註解（Comment）？

註解是 **不會被 Python 執行** 的文字，通常用來解釋程式邏輯、標註重點、提醒未來的自己或團隊。

### 寫法語法：
```python
# 這是一行註解
x = 10  # 註解也可以寫在程式碼後方
```

### 快速註解技巧（適用多數編輯器）：
- **Windows / Linux**：`Ctrl + /`
- **macOS**：`Command + /`

---

## 什麼是 Docstring（說明文件）？

Docstring 是寫給 **函式、類別、模組** 的內建文字說明，它不是普通的註解，而是**可以被程式存取的說明內容**。

### 語法：
```python
def greet(name):
    """
    傳入名字並回傳問候語。
    """
    return f"Hello, {name}!"
```

你可以使用三個雙引號 `""" ... """` 或三個單引號 `''' ... '''` 包住說明。

---

## Comment 與 Docstring 差在哪？

| 功能 | Comment | Docstring |
|------|---------|-----------|
| 用途 | 解釋程式邏輯 | 說明函式 / 類別 / 模組用途 |
| 寫法 | `#` 開頭 | `"""文字"""` 或 `'''文字'''` |
| 位置 | 任意 | 僅能放在**定義之後** |
| 是否可透過程式存取 | ❌ 否 | ✅ 可用 `help()` 或 `.__doc__` |

---

## 使用 Docstring 的好處

1. 可用 `help()` 查詢說明  
2. 自動生成 API 文件  
3. 團隊更容易理解彼此的程式碼

### 範例：
```python
def add(a, b):
    """
    回傳 a + b 的結果。
    
    參數:
        a (int or float): 數值1
        b (int or float): 數值2

    回傳:
        整數或浮點數
    """
    return a + b

print(add.__doc__)
help(add)
```

---

## 🧑‍🏫 Docstring 標準寫法建議（推薦）

可以參考 [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)，以下是建議格式：

```python
def divide(x, y):
    """
    回傳 x 除以 y 的結果。

    參數:
        x (float): 被除數
        y (float): 除數，不能為 0

    回傳:
        float: 商數結果

    範例:
        >>> divide(10, 2)
        5.0
    """
    return x / y
```

---

## Docstring 也能用在類別中！

```python
class Animal:
    """
    動物基礎類別，定義所有動物的共用邏輯。
    """
    def __init__(self, name):
        self.name = name

a = Animal("Dog")
print(Animal.__doc__)
```

---

## 💡 Docstring 撰寫小技巧

| 技巧 | 說明 |
|------|------|
| ✅ 放在定義後的第一行 | 否則不會被辨識為 docstring |
| ✅ 使用完整句子 | 可幫助他人快速理解功能用途 |
| ✅ 可搭配 IDE 自動補全 | 好維護又易閱讀 |
| ❌ 不要寫成純註解 | `#` 開頭不會被當作 docstring |

---

## 互動式小測驗！你掌握了嗎？

1️⃣ 以下哪個是合法的 Python 註解？  
```python
# 這是註解  
// 這是 C 語言註解？  
/* 這是 Java 的寫法？ */
```

2️⃣ Docstring 一定只能使用 `"""` 嗎？可以用什麼取代？

3️⃣ 如何查詢某個函式的 docstring 說明？

4️⃣ 請用 Docstring 寫一個 `say_hi(name)` 函式的說明。

---

## 小結

| 工具 | 用途 |
|------|------|
| `#` | 註解，說明程式邏輯 |
| `"""..."""` | docstring，說明函式或類別用途 |
| `help(obj)` | 查詢對象的 docstring |
| `. __doc__` | 直接取得 docstring 字串 |

---

## 腦力激盪

> 你在寫程式時有習慣加上註解或 docstring 嗎？你認為它們在團隊合作或未來維護上能發揮什麼效果呢？歡迎留言一起討論～

---
