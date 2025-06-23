---
title: Python OOP入門指南 (一) ：繼承
description: 初學 Python 看不懂 class 繼承？這篇用最生活化的範例，帶你一步步理解繼承、__init__ 、self、 super() 的用法。
slug: python-inheritance-guide2
date: 2025-05-25 11:00:00+0000
image: python_inheritance.png
categories:
- Python
- 程式設計
- OOP
- 物件導向
tags:
- Python基礎
- OOP
- class
- 繼承 inheritance
- super
weight:
---
-------

## 什麼是繼承？

繼承是物件導向中的一個重要概念。簡單來說：

子類別（子 class）可以擁有父類別的屬性（Attribute）和方法（Method），不用重新寫一遍。
<br> 就像你從父母那裏繼承了身高、髮色，甚至壞習慣（？）  

---
**在開始介紹繼承前，我們先來看一下這段程式碼:**


```python
class Product:
    def __init__(self, name, price):
        self.name = name  # 將傳入的 name 存成物件的屬性
        self.price = price

Product("果汁", 30)  # 建立物件時，會自動執行 __init__() 方法。
```

## 什麼是 __init__( )？為什麼每個類別都有它？
你可以把 __init__( ) 想像成「物件的出生設定」，它會自動幫你設定這個物件的「初始狀態」，例如名稱、價格等等。物件一創出生時，這個方法就會自動被執行，設定好初始資料。


**__init__( ) 有一個專業術語叫 "constructor （建構子"）** : 
這是用來初始化物件、在物件「出生」的那一刻就自動執行。

### 為什麼需要 constructor（建構子）？

```python
# 如果沒有 __init__()
p = Product()  
p.name = "果汁"  # 就得手動幫每個物件設定屬性
p.price = 30
```
```python
# 但使用 __init__()
p = Product("果汁", 30)  # 只要一句話就完成
```

## 什麼是self？

self 指的是「目前這個物件本身」。就像你在介紹自己：「我的名字是 self.name」，這樣每個物件就能記住自己的資料。


## 小結:

* __init__ 是 **對物件進行初始化** 的特殊方法（constructor）。
* self 是 **物件本身**，指的是這個 class 所建立出來的物件。
--- 
<br>

介紹完了__init__和self, 我們就可以來寫繼承了:<br>
首先，繼承的基礎寫法為 **class 子(父)** ， 代表子繼承父的屬性及方法。

## 繼承 (基礎寫法): 
```python
class Product: # 先創建一個Product類別
    def __init__(self, name, price):  # 這是創建物件時會裝入的初始化功能
        self.name = name  # self.屬性name
        self.price = price  # self.屬性price

class Drink(Product):  # (子)繼承(父)
    def __init__(self, name, price, volume):
        Product.__init__(self, name, price)  # (1)
        self.volume = volume  # (2)
```
這裡我們做了幾件事 : (1)「手動」呼叫父類別 Product 的 __init__( )，來初始化 name 和 price，然後再 (2) 自己新增 volume。



我們來看這一句 :<br> 
```python
        Product.__init__(self, name, price)  # 呼叫父類別的 __init__方法 
```
**(父類別名稱).__init__(self,...)**
這種寫法看似沒什麼問題，但會有幾個缺點：

- 如果未來父類別名稱改變，這裡也必要跟著一起改 → 維護困難。

- 若有多重繼承（萬一同時繼承多個父類別）會搞混。



---


為了解決上述問題，Python 提供了 super( ) 內建函式：

## 什麼是 super( )？

super( ) 用來從子類別中呼叫父類別的方法。super( ) 代表的是「父類別」，但不用寫死父類別的名字。

```python
# ✅ 推薦寫法（更安全、彈性高、支援多重繼承） 
super().__init__(name, price)

# 不推薦寫法（不夠彈性、父類別名稱寫死，未來難改）
Product.__init__(self, name, price)
```
---
所以我們可以這樣寫
## 繼承 (進階寫法)
```python
class Drink(Product): 
    def __init__(self, name, price, volume):
        super().__init__(name, price)  # 呼叫父類別的 __init__
        self.volume = volume  
```
如果你未來把 Product 改名成 Item ， 用 super( ) 就不需要手動修改任何東西。

### 小結:
> **當你想在「原本功能不變」的基礎上加一點自己的功能，就用 super() 把父類的東西也一起執行。**


## 總結：
| 概念                   | 解釋                |
| -------------------- | ----------------- |
| __init__()         | 物件初始化方法（像是出生設定）   |
| constructor          | 建構子，負責建立物件時的初始化行為 |
| self               | 指向目前的物件本身         |
| Product.__init__() | 明確呼叫父類別的方法（不推）   |
| super().__init__() | 推薦方式，維護性高，更安全     |


---


## 繼承 (完整範例)

```python
class Drink(Product): 
    def __init__(self, name, price, volume):
        super().__init__(name, price)  # 輕鬆繼用 Product 的設定
        self.volume = volume  # Drink 自己的新屬性

d = Drink('珍珠奶茶', 80, 600) # 投入參數
print(d.name)     # 珍珠奶茶
print(d.price)    # 80
print(d.volume)   # 600
```

---


## 常見問題 Q&A

### Q1: 為什麼要繼承？

**A:** 繼承可以讓我們重複使用既有的程式碼，避免每個類別都重頭寫一次。比如你定義了一個 Product 類別，之後建立 Drink、Snack 等類別時，就能直接繼承 Product 的屬性與方法，只補上各自特有的部分即可。

### Q2: 一定要用 `super()` 嗎？

**A:** 沒有硬性規定，你也可以直接用 `Product.__init__(self, name, price)`，但 `super()` 是更推薦的寫法，特別是後續有多重繼承時會更簡潔。



### Q3: 子類別可以新增自己的方法嗎？

**A:** 當然可以！你可以在 Drink 裡加上任何想加的方法或屬性。

### Q4: 如果子類別沒有寫 `__init__` 會怎樣？

**A:** Python 會自動使用父類別的 `__init__()`，不會報錯，只是就無法加入子類別自己的新屬性了 **# (1)**。

```python
class Product:
    def __init__(self, name, price):
        self.name = name
        self.price = price

# (1)子類別沒有寫 __init__()
class Snack(Product):
    pass

s1 = Snack("洋芋片", 50)
print(s.name)   # 洋芋片
print(s.price)  # 50



# (2)子類別有寫 __init__() 
class Snack(Product):
    def __init__(self, name, price, flavor):
        super().__init__(name, price)
        self.flavor = flavor  # 可以加上新屬性

s2 = Snack("洋芋片", 50, "鹽味")
print(s.name)   # 洋芋片
print(s.price)  # 50
print(s.flavor)  # 鹽味

```

### Q5: 可以繼承多個父類別嗎？

**A:** 可以，Python 支援 **多重繼承**，例如：`class A(B, C)`，但建議初學者先從單一繼承開始學起。

---

## 🤔 腦力激盪

如果你要寫一個 Student 類別，你會繼承 Person 還是 Teenager？為什麼？

---

(參考答案)

* 初階想法：
我會繼承 Teenager，因為大多數學生是青少年，而 Teenager 裡的屬性像「打工」或「升學壓力」也適用，直接用比較方便。

* 進階想法：
如果我的 Student 類別要包含國小、國中、高中、研究所，那就不適合只繼承 Teenager，應該回頭繼承 Person，再自己定義年齡區段或學級屬性。
---
感謝閱讀這篇簡單實用的繼承入門指南，希望你有更熟悉 class 的應用！~



