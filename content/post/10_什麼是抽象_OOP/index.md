---

title: Python OOP入門指南 (二) ：抽象  掌握 ABC 與 @abstractmethod
description: 本篇教你從零開始理解什麼是 Python 的抽象類別（abstract class），用簡單範例幫助新手學會設計規範與繼承。
slug: python-abstract-class-guide
date: 2025-05-26 10:00:00+0000
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
-------



## 抽象類別是什麼？

**抽象類別（Abstract Class）** 是一種 **無法被直接實例化** 的類別，它的主要用途是作為「模板」提供一套明確的設計規範，讓子類別去實作必要的方法。

簡單來說，抽象就是隱藏不必要的細節，保留對使用者有意義的部分。



想像你在便利商店點飲料，你只會按下「冰美式」，不會去控制水溫、豆量、壓力值。咖啡機幫你包辦了背後的複雜程序，而你只需要操作「make_drink()」這個介面。

> **抽象讓你只看見「你需要的操作」，不被內部細節干擾。**

## 抽象類別的三大特性：

* **不能直接建立實例**
* **包含一個或多個抽象方法**
* **子類別必須實作所有抽象方法才能使用**


> **抽象類別像是一份“介面契約”，強迫所有子類別遵守這份規定，避免遺漏必要功能。**



## 為什麼要使用抽象類別？

| 優點     | 說明                 |
| ------ | ------------------ |
| 統一規範   | 強制子類別都實作特定方法，確保一致性 |
| 易於擴充   | 子類別的功能結構清晰，不易出錯    |
| 避免遺漏   | 每位開發者知道該實作哪些方法     |
| 適合團隊合作 | 明確開發規範，合作更順暢       |

---

## Python 如何實作抽象類別？

Python 並不像 Java、C++ 內建 abstract 關鍵字，而是透過內建模組 `abc`（Abstract Base Class）來達成。

## 建立抽象類別的三步驟 :

### 第一步：匯入模組

```python
import abc 
from abc import ABC, abstractmethod  # ABC 是內建的抽象類別基底類別
```


可不要覺得 ABC 是因為人家懶得想名字而隨便取的唷 <br>
只是簡寫真的剛好是ABC~ 


**abc = 模組名稱** <br> 
**ABC = Abstract Base Classes (模組基底類別)** <br>
**@abstractmethod = 用來定義抽象方法的裝飾器**

### 第二步：定義抽象類別與抽象方法

```python
class Animal(ABC):  # 繼承 ABC 成為抽象類別
    @abstractmethod
    def make_sound(self):  # 抽象方法，沒有實作內容
        pass
```

### 第三步：由子類別實作抽象方法

```python
class Dog(Animal):
    def make_sound(self):  # 必須實作父類別的抽象方法
        print("汪汪！")

class Cat(Animal):
    def make_sound(self):
        print("喵喵！")
```


一旦類別中包含 `@abstractmethod` 方法，該類別就**不能被實例化**。
<br>它會標記一個方法為「抽象」，代表這個方法**在父類別中不提供實作細節，而是留給子類別自行定義。**

如果子類別沒有實作所有抽象方法，將無法建立該類別的實例，會拋出 TypeError。(看下方範例)




```python
class Dog(Animal):
    def make_sound(self):
        print("汪汪")  # 有實作 ✔️

d = Dog()  # 建立實例
d.make_sound()  # 汪汪
```


```python
class Dog(Animal):
    def make_sound(self):
        pass  # ❌ 雖然語法正確，但沒有實際內容，視為未實作

# d = Dog()  ❌ TypeError: Can't instantiate abstract class Dog with abstract method make_sound
```

---

## ✅ 完整範例：動物叫聲系統

```python
from abc import ABC, abstractmethod

# 抽象類別
class Animal(ABC):
    @abstractmethod
    def make_sound(self):
        pass

    def sleep(self):
        print("Zzz...")  # 抽象類別也可有一般方法

# 子類別實作
class Dog(Animal):
    def make_sound(self):
        print("汪汪！")

class Cat(Animal):
    def make_sound(self):
        print("喵喵！")

# a = Animal()  # ❌ TypeError：無法建立抽象類別的實例

d = Dog()
d.make_sound()  # 汪汪！
d.sleep()       # Zzz...
```

---

## 💬 常見問題 Q\&A

### Q1: 抽象和封裝有什麼不同？

抽象是隱藏實作行為、只對外提供接口；封裝是保護資料不被任意存取。

### Q2：一定要用 `ABC` 嗎？

是的，繼承 `ABC` 或使用  `metaclass = ABCMeta`  是 Python 抽象類別的必要設定。

```python
# 另一種寫法
class Animal(metaclass=abc.ABCMeta):
    @abc.abstractmethod
    def make_sound(self):
        pass
```

### Q3：如果子類別沒有實作抽象方法會怎樣？

會在建立子類別實例時拋出 `TypeError`，提醒你沒有實作必要的方法。 <br>
**(↑看上面動物叫聲系統範例)**

### Q4：抽象類別可以包含普通方法嗎？

可以。除了抽象方法，也可以寫一般方法，提供子類別共用的功能。

```python
class Animal(ABC):
    @abstractmethod
    def make_sound(self):    # 抽象方法
        pass    # 沒有實作內容，只是一個規範接口

    def sleep(self):         # 一般方法
        print("Zzz...")
```

### Q5：抽象類別可以加屬性嗎？

可以，但建議放共用或初始化用的屬性，具體邏輯留給子類別處理。

### Q6：什麼時候應該使用抽象類別？

當你希望每個子類別都遵守統一規則或結構（如：付款、載具、通知類別）。

### Q7：ABC 是什麼？和 metaclass=ABCMeta 有什麼關係？

ABC 就是 metaclass=ABCMeta 的語法糖（syntactic sugar）。
寫 `class A(ABC):` 的效果等同於 `class A(metaclass=ABCMeta)`。
這樣寫更簡潔可讀，也更常見

---

## 💡 延伸補充：metaclass 是什麼？

在 Python 中，一切皆物件，**類別也是一種物件**，它的類型就是 `type`。

```python
class Product:
    pass

print(type(Product))  # <class 'type'>
```
也就是說：

1. Product 是一個類別（class）

2. 但它本身也是一個物件

3. 它是由 type 類別創造出來的物件（也就是 Python 中預設的 metaclass）

```python
from abc import ABC, abstractmethod

class Animal(ABC):  # 背後其實是 metaclass=ABCMeta
    @abstractmethod
    def make_sound(self):
        pass

```

當你使用 `metaclass=ABCMeta`，就是告訴 Python 使用一個特別的類型（MetaClass）來定義這個類別，使其具備「抽象類別」的行為。

---

## 總結：建立抽象類別 3 步驟

1️⃣ `from abc import ABC, abstractmethod` <br>
2️⃣ `class 類別名(ABC):` <br>
3️⃣ 用 `@abstractmethod`  <br>

抽象類別是一種讓程式設計更有「架構」的利器，特別適合用在大型專案或多人開發時統一規格。

<br>

## 🤔 腦力激盪 - 支付模組設計

假設你正在寫一個支付模組（Payment），有哪些方法應該是抽象的？你會怎麼實作 `CreditCard`、`LinePay`、`街口支付` 等子類別？

---

(參考答案)<br><br>
(1) 我們可以先定義一個抽象基底類別 Payment，所有支付方式都要遵守以下統一接口：
```python
from abc import ABC, abstractmethod

class Payment(ABC):
    @abstractmethod
    def authorize(self, amount):
        """驗證是否可以付款，例如檢查餘額或授權碼"""
        pass

    @abstractmethod
    def pay(self, amount):
        """執行實際付款邏輯"""
        pass

    @abstractmethod
    def refund(self, amount):
        """退款流程"""
        pass

```

(2) 子類別實作 (CreditCard 信用卡支付 、 LinePay 、 街口支付)

```python
class CreditCard(Payment):
    def authorize(self, amount):
        print(f"信用卡授權 {amount} 元通過")

    def pay(self, amount):
        print(f"已用信用卡付款 {amount} 元")

    def refund(self, amount):
        print(f"已退還信用卡款項 {amount} 元")
```

```python
class LinePay(Payment):
    def authorize(self, amount):
        print(f"LinePay 授權成功，金額：{amount}")

    def pay(self, amount):
        print(f"LinePay 完成付款 {amount} 元")

    def refund(self, amount):
        print(f"LinePay 退款 {amount} 元成功")
```

```python
class JKOPay(Payment):
    def authorize(self, amount):
        print(f"街口支付已授權 {amount} 元")

    def pay(self, amount):
        print(f"街口支付完成付款 {amount} 元")

    def refund(self, amount):
        print(f"街口支付已完成退款 {amount} 元")
```

```python
def process_payment(method: Payment, amount: int):
    method.authorize(amount)
    method.pay(amount)
    method.refund(amount)

process_payment(CreditCard(), 500)
process_payment(LinePay(), 800)


# 信用卡授權 500 元通過
# 已用信用卡付款 500 元
# 已退還信用卡款項 500 元

# LinePay 授權成功，金額：800
# LinePay 完成付款 800 元
# LinePay 退款 800 元成功

```
以上實作包含了OOP中**抽象**和**多型**的應用：
- 抽象（Abstraction） 是為了建立統一的介面，像 authorize()、pay()、refund()。

- 多型（Polymorphism） 則是利用這個介面，讓不同子類（如 CreditCard, LinePay）在 不改變函式 process_payment() 寫法的前提下實現不同的行為。

下個章節會帶大家更了解OOP的多型! 請拭目以待~

---