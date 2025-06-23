---

title: Python OOP入門指南 (三) ：封裝
description: 初學 Python 的 OOP 概念看不懂？這篇文章用實際生活例子，幫你搞懂什麼是封裝（Encapsulation）以及為什麼這麼重要。
slug: python-encapsulation-guide
date: 2025-05-25 14:00:00+0000
image: python_encapsulation.png
categories:

- Python
- 程式設計

tags:

- Python基礎
- OOP
- class
- 封裝 encapsulation
- 資料保護

---
-------

## 什麼是封裝（Encapsulation）？

**封裝**的目的是將資料（属性）與操作資料的方法（函式）包在一起，隱藏內部實作細節、只露出必要介面供外部使用者座使用。是一種防止外不去呼叫存取內部實作細節的手段。

就像你有一個銀行帳戶，不能讓別人直接改寫餘額，而是必須經由“安全的操作方法”來進行。


## 封裝的重要性

1. **提高安全性：** <br>
將屬性設為私有（private），讓外部不能直接改動，只能透過特定方法（Getter / Setter）來間接操作，防止不當存取與資料錯誤。

2. **方便維護與修改：**<br>
封裝後就算內部實作有更改，只要對外的介面（方法）不變，使用者的程式碼就不用跟著改，這樣可大大提高程式的穩定性與相容性。

3. **降低耦合（Coupling）：**<br>
外部不需要知道內部實作細節，只需使用提供的接口，模組間彼此獨立，能降低錯誤傳染風險。

4. **增加內聚（Cohesion）：**<br>
同一個類別裡的屬性和方法都是相關的，將功能集中在一起，就不會雜亂無章。這樣讓類別更清楚、更有組織性。

5. **更容易除錯和測試：**<br>
將狀態變數藏起來，錯誤發生時可追蹤到特定的操作流程，更容易發現錯誤問題點。

6. **支持抽象化思考：**<br>
封裝配合繼承與多型，使得開發者可以只專注於 這個類別能「做什麼」而不是「怎麼做」。



## 如何在 Python 中實現封裝？
Python 沒有像 Java 那樣明確的 private / protected 關鍵字，但透過「**命名規則**」與「**裝飾器**」也能達到相同效果。

在了解真正實現封裝前，我們先來看一下 Python 中有哪些屬性存取層級。

## 公開到私有層級介紹

### 1. 公開屬性 (public)

```python
class Person:
    def __init__(self):
        self.name = "小明"  # 公開屬性

p = Person()
print(p.name)     # 可讀
p.name = "小美"     # 可改

```
> 一般的寫法無法實現封裝，因為任何人都可以自由讀寫修改。

### 2. 受到保護的 protected ( `_變數名稱 ` 前面加單底線)
(雖然之前已經寫過文章詳細說明底線(underscore)用法了，但還是幫大家再複習一下)

```python
class Employee:
    def __init__(self):
        self._salary = 30000  # Protected 屬性

e = Employee()
print(e._salary)      # ⚠️ 可以讀，但通常會建議讓內部使用

```
>**單底線是 Python 的約定俗成，意思是"建議不要外部直接使用"，但不是強制。** <br>（只是約定，不是真正保護）



### 3. 私有屬性 Private  (`__變數名稱 ` 前面加雙底線)
外部無法直接存取，會經過名稱改寫（name mangling）。

```python
class BankAccount:
    def __init__(self):
        self.__balance = 1000  # 私有屬性

acc = BankAccount()
print(acc.__balance)     # ❌ AttributeError


# 因為實際上變成了 _BankAccount__balance：
print(acc._BankAccount__balance)  # 可存取（但沒事不要這樣做）
```
> 雙底線代表私有屬性，`__變數名` 會被轉換成 `_類別名__變數名`，理論上使用`_類別名__變數名`可以被存取，但原則上不要直接存取。
---
## 封裝用 Getter 和 Setter 方法

如果你想實現真正的封裝，且無法讓外部直接改動屬性，我們可以使用 **Getter 和 Setter 方法**來達成。

### 🔹 Getter 是什麼？

「**讀取私有屬性**」的方法，搭配 `@property` 裝飾器。<br>
目的是"想讓使用者像操作變數一樣簡單，但又希望在背後加上邏輯限制或驗證條件"。

### 🔹 Setter 是什麼？

「**設定私有屬性**」的方法，搭配 `@變數.setter`裝飾器。<br>
可以加入條件判斷，例如不接受負值，或自動做格式檢查。


## 封裝範例-提款卡操作帳戶（簡單版）

```python
class BankAccount:
    def __init__(self):
        self.__balance = 1000   # 私有屬性

    @property
    def balance(self):          # Getter：讀取餘額
        return self.__balance

    @balance.setter
    def balance(self, value):   # Setter：設定餘額（+ if條件）
        if value >= 0:
            self.__balance = value
        else:
            print("餘額不能是負數！")
            
acc = BankAccount()    # 設定 __balance = 1000（初始化）
print(acc.balance)     # 1000
acc.balance = 2000     # 觸發 @balance.setter()，修改成 2000
acc.balance = -999     # ❌ 錯誤訊息:餘額不能是負數！

```


你可以這樣理解：

```python
value = acc.balance       # 看起來像取值，其實是呼叫 getter
acc.balance = 1000        # 看起來像賦值，其實是呼叫 settersetter(1000)

```
<br>

## 封裝範例延伸- 加入帳戶擁有者（進階版）

```python
class BankAccount:
    def __init__(self, owner, balance):
        self.owner = owner
        self.__balance = balance  # 私有屬性

    @property                  
    def balance(self):  
        return self.__balance

    @balance.setter            
    def balance(self, value):  
        if value >= 0:
            self.__balance = value
        else:
            print("餘額不能是負數！")

account = BankAccount("小美", 500)   # 建立帳戶並設定初始餘額
print(account.balance)   # 500

account.balance = 800    # 觸發 @balance.setter() 設定新餘額 800
print(account.balance)   # 800

account.balance = -100   # ❌ 嘗試設負數，顯示錯誤
```



## 總結

| 寫法               | 可見性  | 推薦用途            |
| ---------------- | ---- | --------------- |
| `self.name`      | public   | 完全公開，可隨意存取與修改     |
| `self._salary`   | protected  | 半封裝，用於內部提示      |
| `self.__balance` | private   | 真正封裝，只能透過方法或屬性存取 |
| `@property`      | 間接讀取 | 控控制讀取方式，可加入驗證邏輯        |
| `@setter`        | 間接寫入 | 控制修改方式，可設定限制或保護資料   |

---


## ❓常見問題 Q&A

### Q1: 雙底線 `__` 是絕對私有嗎？

**A:** 並不是。它其實會被 Python 自動轉換成 _類別名__變數名，可以存取但通常不會這樣做，應視為私有。

### Q2: 什麼時候適合用封裝？

**A:** 當資料是關鍵、敏感或容易錯誤時，封裝能幫助你減少錯誤、提高程式可維護性，是寫好程式、好維護程式的基礎。

### Q3: @property 和 @setter 是語法糖嗎？

**A:** 是的，它們是語法糖。表面看起來像在存取或賦值變數，但實際上是在執行函式（方法）。這樣能讓程式碼更直覺、可讀性更高，同時仍保留封裝與邏輯驗證的能力。

<br>

## 🤔 腦力激盪

假設你有一個 Student 類別，裡面有成績 score 屬性，你會不會想用封裝來保護它？為什麼？歡迎留言告訴我你的想法！

---

(參考答案)

會。
會選擇用封裝保護 score 屬性，因為成績是比較敏感的資料，如果沒有控制，可能會被亂設成負數或超過滿分，影響資料正確性。
透過 @property 和 @setter，我可以限制成績範圍只能在 0 到 100 之間，也方便之後要做成績加權或轉換等邏輯。


