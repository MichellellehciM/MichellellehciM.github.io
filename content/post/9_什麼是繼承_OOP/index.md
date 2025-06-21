---

title: Python OOP入門指南 (一) ：繼承
description: 初學 Python 看不懂 class 繼承？這篇用最生活化的範例，帶你一步步理解繼承。
slug: python-inheritance-guide
date: 2025-04-25 11:00:00+0000
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
-------

# Python 繼承入門指南：用簡單範例搞懂 OOP！

你是不是剛學 Python，看到 `class A(B)` 就開始頭痛？

別擔心！這篇文章會用一個最生活化的例子：「商品【Product】與飲料【Drink】」來帶你認識 **繼承（Inheritance）**。

---

## 什麼是繼承？

在 Python 中，一個 class 可以從另一個 class 繼承屬性與方法。就像你從父母那裏繼承了身高、髮色，甚至壞習慣（？）

```python
class Product: # 創建Product類別
    def __init__(self, name, price):
        # 這是創建物件時會裝入的初始化功能
        # self 指的就是 "本人（本物件）"
        self.name = name  # self.屬性name
        self.price = price  # self.屬性price

    def __str__(self):
        return f'{self.name} ${self.price}'
```

### 註記:

* `__init__` 是 **對物件進行初始化** 的特殊方法（constructor）
* `self` 是 **物件本身**，指的是這個 class 所建立出來的物件

---

## 子類別繼承父類別

```python
class Drink(Product): # Drink類別(子) 繼承Product類別(父)
    def __init__(self, name, price, volume):
        super().__init__(name, price)  # 呼叫父類別的 __init__
        self.volume = volume  # 自己加上新的屬性 volume
```

### 註記:

* `super().__init__(...)`：不用重複編寫 name 和 price 的設定方法，**直接繼用父類別的還更乾脆利落**

### 什麼是 `super()`？

> `super()` 是 Python 提供的內建函式，用來從子類別中呼叫父類別的方法。

你可以把 `super()` 想成是從子類別引導進入父類別的一條通道，或是一個「通行證」，讓你可以直接使用父類別已定義好的功能。

```python
super().__init__(name, price)  # 就是呼叫 Product.__init__()
```

> ✅ 好處：不需直接指定父類別名稱，維護性更高，對 **多重繼承** 特別有利

### 🔸 為什麼要有 super()？

假設你覆寫了父類別的方法（例如 `__init__()`），但仍想保留原本父類別的初始化邏輯，就會需要 `super()`。

### 🔸 實際例子：呼叫父類別的方法

來看一個和原本商品主題有關、但加入 `super()` 的生活化例子：

```python
class Product:
    def describe(self):
        print("這是商品")

class Drink(Product):
    def describe(self):
        super().describe()  # 呼叫父類別的方法
        print("這是飲料商品")

juice = Drink()
juice.describe()
```

#### 輸出結果：

```
這是商品
這是飲料商品
```

這裡 `Drink` 覆寫了 `describe()`，但透過 `super()` 保留了 `Product` 的原始敘述。這就像你介紹一杯果汁時，會先說它是商品，再補充「它是飲料類型」。

✅ **為什麼要用 `super()`？**

* 若你想 **擴充** 父類別功能，而不是完全蓋掉，就可以透過 `super()` 把原本的內容也執行一次。
* 對於需要疊加邏輯的場景非常實用，例如日誌紀錄、基礎設定等。

#### 輸出結果：

```
動物發出聲音
狗狗汪汪叫
```

這裡 `Dog` 覆寫了 `make_sound()`，但透過 `super()` 保留了 `Animal` 的邏輯，實現「擴充」而非「取代」。

---

## ✨ 為什麼要繼承？

* **減少重複程式碼**：Drink 不用重寫 `name` 和 `price` 的處理方式
* **維護更容易**：只要改 `Product`，Drink 自動有效
* **更符合真實世界思維**：飲料本身就是一種商品

---

## 完整範例

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

## ❓初學者常見問題 Q\&A

## Q1: 一定要用 `super()` 嗎？

**A:** 不一定，你也可以直接用 `Product.__init__(self, name, price)`，但 `super()` 是更推薦的寫法，特別是後續有多重繼承時會更簡潔。

## Q2: `super()` 是什麼意思？

**A:** 它是 Python 提供的內建函數，表示 "父類別"，可以用來呼叫被 override 的方法，像是 `__init__()` 。

## Q3: 子類別可以新增自己的方法嗎？

**A:** 當然可以！你可以在 Drink 裡加上任何想加的方法或屬性。

## Q4: 如果子類別沒有寫 `__init__`，會怎樣？

**A:** Python 會自動使用父類別的 `__init__()`，不會報錯，只是無法加上新屬性而已。

## Q5: 可以繼承多個父類別嗎？

**A:** 可以，Python 支援 **多重繼承**，例如：`class A(B, C)`，但建議初學者先學單一繼承。

---

## 🤔 腦力激盪

> 如果你要寫一個 `Coffee` 類別，你會繼承 `Product` 還是 `Drink`？為什麼？留言跟我分享你的思維！

---

感謝閱讀這篇簡單實用的繼承入門指南，希望你從此不再怕 class！💪
