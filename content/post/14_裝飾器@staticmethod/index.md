---

title: Python 靜態方法（@staticmethod）新手教學：什麼時候該用？
description: 本文將帶你從零開始理解 Python 中的 @staticmethod 是什麼、與一般方法的差別、什麼時候該使用，搭配實用範例與常見問答，幫助你輕鬆掌握靜態方法的觀念。
slug: python-staticmethod-guide
date: 2025-05-01 10:00:00+0800
image: python_staticmethod_guide.png
categories:
  - Python
  - 程式設計
tags:
  - Python基礎
  - staticmethod
  - OOP
  - 類別與物件
---


在學 Python 類別的時候，你可能會遇到這樣的寫法：
```python
class MathTool:
    @staticmethod  
    def add(x, y):
        return x + y
```


咦？這段程式碼怎麼沒有 self 或 cls 呢？這就是 **靜態方法（static method）** 的特色。


---

##  什麼是 static method？

@staticmethod 是一種定義在「類別中」但 **不需要依賴實例或類別本身** 的方法。

簡單說：「它只是剛好寫在 class 裡的普通函式」。

---

##  一般方法  vs  staticmethod

```python
class Dog:
    def bark(self):  # 一般方法（會自動接收 self 參數）
        print("汪")

dog = Dog()    # 建立 Dog 類別的實例
dog.bark()     # 汪  (會自動把 dog 當成 self 傳入)
Dog.bark()     # ❌ TypeError ：少了 self → 呼叫失敗

```

```python
class Dog:
    @staticmethod    # staticmethod 裝飾器
    def greet():     # 靜態方法（不需要 self/cls）
        print("Hello!")

Dog.greet()    # Hello!

dog = Dog()   
dog.greet()    # 也可以（但不推薦，會讓人以為與物件有關）

```



---

| 方法類型       | 是否自動傳入參數 | 第一個參數 | 呼叫方式           |
|----------------|------------------|-------------|---------------------|
| 一般方法        | ✅ 是             | self      | dog.bark()        |
| 靜態方法        | ❌ 否             | 無          | Dog.greet() or dog.greet() |

---

## 範例：工具類別中的靜態方法

```python
class MathTool:  #定義一個類別 MathTool，用來裝一些數學相關的工具方法。
    @staticmethod  # 靜態方法裝飾器
    def add(x, y):  #接收兩個引數，不需 self
        return x + y
# 呼叫靜態方法（類別名.方法名），不需要先建立物件
print(MathTool.add(5, 7))  # 類別直接呼叫，輸出 12
```


###  為什麼要這樣用？
因為 add(x, y) 跟這個類別沒有關聯，它只是個通用的小工具。

---

## 什麼時候該用 staticmethod？

使用 @staticmethod 的時機：
- 方法邏輯**不需要使用實例資料（self）**
- 方法邏輯**不需要使用類別屬性（cls）**
- 只是單純提供工具功能（像 加法、格式轉換）

---

## ❌ 常見錯誤與誤解


沒加 @staticmethod 就直接寫
```python
class Tool:
    def convert():  # ❌ 會錯：缺 self
        pass
```


正確寫法應該是：
```python
    @staticmethod
    def convert():
        pass
```


---

## 新手常見 Q&A

### Q1：staticmethod 和 classmethod 有什麼不同？
| 裝飾器         | 傳入參數 | 用途                         |
|----------------|----------|------------------------------|
| @staticmethod| 無       | 完全獨立的工具方法           |
| @classmethod | cls    | 要操作「類別本身」的資料     |

---

### Q2：為什麼不直接把函式寫在 class 外面？
你可以！不過放在 class 裡面可以：
- 表示這是「這個類別的功能」
- 對讀者來說更組織清楚

---

### Q3：static method 可以用物件呼叫嗎？
可以，但沒意義。

```python
m = MathTool()
print(m.add(2, 3))  # ✅ 可以，但建議直接 MathTool.add(...)
```


---

## 🧩 小挑戰：來試試看！

請你自己動手寫一個類別 TextUtils，裡面有一個 @staticmethod 方法 word_count(text)，可以計算一段文字的單字數量。

```python
print(TextUtils.word_count("hello world! this is python.")) # 應該輸出：5
```


---

## 總結

| 問題                             | 說明 |
|----------------------------------|------|
| static method 是什麼？           | 不需要 self/cls 的類別方法 |
| 怎麼寫？                         | 用 @staticmethod 裝飾器 |
| 什麼時候用？                     | 當你寫的是跟類別/實例無關的功能 |
| 有什麼好處？                     | 更清楚的程式組織、更好維護 |

---

## 💬 腦力激盪：你覺得以下哪個方法最適合用 @staticmethod？

A. 計算一個帳戶的利息  
B. 驗證輸入的 email 格式  
C. 取得目前登入使用者的資訊  

---

(解答)


| 選項             |  說明                                             |
| -------------- | ---------------------------------------------- |
| A. 計算帳戶利息      |  通常需要用到帳戶的餘額等「實例資料」，應使用一般方法（`self`）             |
| B. 驗證 email 格式 ✅ | 純邏輯判斷，不依賴實例或類別屬性，很典型的工具方法                      |
| C. 取得登入使用者資訊   | 可能需從 session 或系統狀態中取資料，通常會用 class method 或其他機制 |

💡 延伸小範例
```python
class Validator:
    @staticmethod
    def is_valid_email(email):
        return "@" in email and "." in email

print(Validator.is_valid_email("test@example.com"))  #  True
```
---
太棒了!!恭喜你已經學會了一種裝飾器的用法。
