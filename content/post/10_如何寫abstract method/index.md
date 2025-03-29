---
title: Python 抽象類別入門指南：掌握 ABC 與 @abstractmethod
description: 本篇教你從零開始理解什麼是 Python 的抽象類別（abstract class），用簡單範例幫助新手學會設計規範與繼承。
slug: python-abstract-class-guide
date: 2024-11-26 10:00:00+0000
image: python_abc_guide.png
categories:
    - Python
    - 程式設計
tags:
    - Python基礎
    - OOP
    - 抽象類別 
    - abstract class
    - 繼承
    - abc 
weight: 
---

# Python 抽象類別（Abstract Class）新手教學

> 適合對象：Python 初學者、有 OOP 概念、想寫出更有結構的程式設計者

---

## 抽象類別是什麼？

**抽象類別（Abstract Class）** 是一種 **無法被直接實例化** 的類別，它的主要用途是作為「模板」提供一套明確的設計規範，讓子類別去實作必要的方法。

### 抽象類別的三大特性：
- **不能直接建立實例**
- **包含一個或多個抽象方法**
- **子類別必須實作所有抽象方法才能使用**

小結：
> 抽象類別像是一份“介面契約”，強迫所有子類別遵守這份規定，避免遺漏必要功能。

---

## 為什麼要使用抽象類別？

| 優點 | 說明 |
|------|------|
| 統一程式設計規範 | 強制子類別都實作特定方法，確保一致性 |
| 提高維護性 | 子類別的功能結構清晰，不易出錯 |
| 團隊協作更順利 | 每位開發者知道該實作哪些方法 |
| 增強程式彈性 | 抽象類別讓你容易擴充與替換子類別 |

---

## Python 如何實作抽象類別？

Python 並不像 Java、C++ 內建 abstract 關鍵字，而是透過內建模組 `abc`（Abstract Base Class）來達成。

### 匯入模組：
```python
import abc
from abc import ABC, abstractmethod
```

- `ABC` 是內建的抽象類別基底類別
- `@abstractmethod` 是裝飾器，用來定義抽象方法

---

## 🛠️ 建立抽象類別的三步驟

### 1️⃣ 宣告繼承自 `ABC`
```python
from abc import ABC

class Animal(ABC):
    ...
```

### 2️⃣ 用 `@abstractmethod` 定義抽象方法
```python
from abc import abstractmethod

class Animal(ABC):
    @abstractmethod
    def make_sound(self):
        pass
```

### 3️⃣ 子類別繼承後必須實作所有抽象方法
```python
class Dog(Animal):
    def make_sound(self):
        print("汪汪！")
```

---

## 完整範例：動物叫聲

```python
from abc import ABC, abstractmethod

# 抽象類別
class Animal(ABC):
    @abstractmethod
    def make_sound(self):
        pass

# 實作的子類別
class Dog(Animal):
    def make_sound(self):
        print("汪汪！")

class Cat(Animal):
    def make_sound(self):
        print("喵喵！")

# 測試
# a = Animal()  # ❌ 會報錯，不能實例化抽象類別

d = Dog()
d.make_sound()  # 汪汪！

c = Cat()
c.make_sound()  # 喵喵！
```

---

## 🙋‍♀️ 常見問題 Q&A

### Q1：抽象類別和普通類別有什麼不同？
A：抽象類別不能直接被實例化，必須由子類別繼承並實作完抽象方法才能建立物件。

---

### Q2：一定要用 `ABC` 嗎？
A：是的，繼承 `ABC` 或使用 `metaclass=ABCMeta` 是 Python 抽象類別的必要設定。

```python
# 另一種寫法
class Animal(metaclass=abc.ABCMeta):
    ...
```

---

### Q3：如果子類別沒有實作抽象方法會怎樣？
A：會在建立子類別實例時拋出 `TypeError`，提醒你沒有實作必要的方法。

---

### Q4：抽象類別可以包含普通方法嗎？
A：可以。除了抽象方法，也可以寫一般方法，提供子類別共用的功能。

```python
class Animal(ABC):
    @abstractmethod
    def make_sound(self):
        pass

    def sleep(self):
        print("Zzz...")
```

---

### Q5：可以加屬性嗎？
A：可以，但建議放共用或初始化用的屬性，具體邏輯留給子類別處理。

---

## 💡 延伸補充：metaclass 是什麼？

在 Python 中，**類別也是一種物件**，它的類型就是 `type`。

```python
class Product:
    pass

print(type(Product))  # <class 'type'>
```

當你使用 `metaclass=ABCMeta`，就是告訴 Python 使用一個特別的類型（MetaClass）來定義這個類別，使其具備「抽象類別」的行為。

---

## 總結：記住這 3 步就能寫出抽象類別！

1️⃣ `from abc import ABC, abstractmethod`  
2️⃣ `class 類別名(ABC):`  
3️⃣ 用 `@abstractmethod` 定義抽象方法

抽象類別是一種讓程式設計更有「架構」的利器，特別適合用在大型專案或多人開發時統一規格。

---

## 腦力激盪

> 看完這篇教學，你學會了什麼？你覺得在什麼情境下會需要抽象類別？  
> 歡迎在留言區分享你的想法，一起討論、成長！

---
