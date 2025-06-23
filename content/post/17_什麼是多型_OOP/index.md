---

title: Python OOP入門指南 (四) ：多型
description: 本篇帶你從零理解 Python 的 OOP 多型（Polymorphism）觀念，透過簡單範例幫助新手掌握同名不同行為的技巧。
slug: python-polymorphism-guide
date: 2025-05-27 10:00:00+0000
image: python_polymorphism_guide.png
categories:
- Python
- 程式設計
tags:
- Python基礎
- OOP
- 多型
- polymorphism
- 繼承
weight:
-------

## 什麼是多型？

**多型（Polymorphism）**是物件導向程式設計的四大特性之一，不同的類別可以使用相同的方法名稱，但根據對象不同，執行的行為也不同。

例如：`speak( )` 在 Dog 是"汪"，在 Cat 是"喵"。


---

## 多型的優點

| 優點              | 說明                                    |
| --------------- | ------------------------------------- |
|  **介面統一**     | 不管是哪一個子類別，使用者都用相同方法呼叫，提升一致性。          |
|  **可擴充性高**    | 新增類別（例如 ApplePay）不用改原本邏輯，只要繼承並實作介面即可。 |
|  **維護性高**     | 改變其中一個子類別的實作，不影響其他類別與主流程。             |
|  **搭配抽象類別使用** | 搭配 `ABC` 實作，可以強制子類別遵守規範，避免遺漏必要方法。     |


---

## 多型的幾種常見用法

1. **繼承 + 方法覆寫（Override）**
2. **抽象類別（Abstract Class）** ← 若不熟建議先閱讀前一篇教學
3. **鴨子型別（Duck Typing）**
4. **內建函式多型（如 len）**

---

## 範例一：繼承與方法覆寫
最常見的方式：透過繼承父類別，並在子類別中重新定義方法。

```python
class Animal:
    def speak(self):
        print("不知道怎麼叫")

class Dog(Animal):
    def speak(self):
        print("汪！")

class Cat(Animal):
    def speak(self):
        print("喵！")

animals = [Dog(), Cat()]
for a in animals:
    a.speak()        # 汪!
                     # 喵!
```

 **說明：** 雖然呼叫的都是 `speak()`，但根據物件型別（Dog or Cat），會自動選擇正確的方法來執行。

---

## 範例二：搭配抽象類別（Abstract Class）

用 abc 模組強制每個子類別都要實作某些方法。

```python
from abc import ABC, abstractmethod

class Payment(ABC):
    @abstractmethod
    def pay(self, amount):
        pass

class CreditCard(Payment):
    def pay(self, amount):
        print(f"信用卡支付 {amount} 元")

class LinePay(Payment):
    def pay(self, amount):
        print(f"LinePay 支付 {amount} 元")

def process_payment(method: Payment, amount):
    method.pay(amount)  # Payment 是 型別提示（Type Hint）
# 這裡的 method 是你傳進來的物件參數，它代表一個「支付方法的物件」，可能是：CreditCard() 的物件、LinePay() 的物件、任何有 .pay() 方法的物件   

process_payment(CreditCard(), 100)   # 信用卡支付 100 元  
process_payment(LinePay(), 200)      # LinePay 支付 200 元
```
主程式只關心介面（pay），不管是信用卡還是行動支付，通通能通用。

---

## 範例三：鴨子型別（Duck Typing）
彈性高，不需繼承自共同父類別，適合快速開發與原型設計。
```python
class Duck:
    def quack(self):
        print("呱呱！")

class Person:
    def quack(self):
        print("我模仿鴨子：呱呱～")

def make_it_quack(obj):
    obj.quack()

make_it_quack(Duck())    # 呱呱！
make_it_quack(Person())  # 我模仿鴨子：呱呱～

```
這就是所謂的「If it quacks like a duck, it's a duck.」—— 不看你是不是鴨子，看你會不會 quack。

---
## 範例四：內建函式多型（如 len）
像 `len( )` 就是多型的例子，它能對字串、列表、字典... 都使用。
```python
print(len("hello"))      # 5
print(len([1, 2, 3]))    # 3
print(len({"a": 1}))     # 1
```



---

## 腦力激盪

假設你正在開發一個通知系統，包含 Email、Line、SMS，你會怎麼設計？會怎麼運用多型？歡迎留言討論！

---

(參考答案)

### **通知系統的多型設計範例 :**
定義一個統一介面 send(message)，不管是 Email、Line 或 SMS，都要實作這個方法。

(1) 抽象類別：Notifier
```python
from abc import ABC, abstractmethod

class Notifier(ABC):
    @abstractmethod
    def send(self, message):
        pass
```

(2) 子類別實作：Email、Line、SMS
```python
class EmailNotifier(Notifier):
    def send(self, message):
        print(f"寄送 Email：{message}")

class LineNotifier(Notifier):
    def send(self, message):
        print(f"發送 Line 訊息：{message}")

class SMSNotifier(Notifier):
    def send(self, message):
        print(f"傳送簡訊：{message}")
```

(3) 使用多型處理通知
```python
def notify_user(notifier: Notifier, message: str):
    notifier.send(message)

# 測試
notify_user(EmailNotifier(), "歡迎使用我們的服務")
notify_user(LineNotifier(), "您的驗證碼是 1234")
notify_user(SMSNotifier(), "付款成功，感謝您的支持")
```