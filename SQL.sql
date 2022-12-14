-- Bu SQL kodları ANSII standartıdır. Yani bu kodlar Oracle, MySQL, MsSQL ve PostgreSQL'de de çalışır.
-- SQL case insensitive yani büyük ve küçük harf duyarsızdır.

/* Select, seç demek. Bir veri kaynağındaki datayı çekmek için kullanılan yapıdır. selectten sonra gelen kısım kolon
lardır. * demek tüm kolonlar demek. Sonrasında veriyi çekeceğimiz tablonun adını yazıyoruz. */

Select * from Customers

-- Sadece 3 tane kolonu getirmesini istedik.
Select ContactName, CompanyName, City from Customers

-- Kolon adlarını alias kullanarak farklı isimlerde gösterebiliriz.
Select ContactName Adi, CompanyName Sirketadi, City Sehir from Customers

-- Filtreleme sorgusu. Where koşul demek. Şehri London olanları getir. Metinler ANSII standartlarına göre tek tırnakla yazılır.
Select * from Customers Where City = 'London'

-- CategoryID 1 olanları veya 3 olanları getir.
Select * from Products Where CategoryID = 1 or CategoryID = 3

-- CategoryID 1 olan ve Price 10'dan büyük olanları getir. <> yaparsak 10'dan farklı olanları getir demek.
Select * from Products Where CategoryID = 1 and Price > 10

-- order by sırala demek. Bütün ürünleri ürün ismine göre sırala.
select * from Products order by ProductName

-- CategoryID'e göre sırala.
select * from Products order by CategoryID

-- 1 numaralı kategorileri kendi arasında ürün ismine göre sıraladık.
select * from Products order by CategoryID, ProductName

-- asc ascending (artan demek). order by'ın default değeri asc.
select *  from Products order by Price asc 

-- desc descending (azalan demek). 
select *  from Products order by Price desc

-- CategoryID 1 olanları seç ve fiyatını azalan olarak getir.
select *  from Products where CategoryID = 1 order by Price desc 

-- count(*), tüm satırların sayısını verir.
select count(*) from Products

-- 2 numaralı kategoride kaç ürün var? Aynı zamanda aliasta kullanabiliriz.
select count(*) Adet from Products where CategoryID = 2

-- group by kullandığımzda select ettiğimiz kolon sadece group by'da yadığımız alan olabilir ve kümülatif datalar olabilir.
-- datalarımın içine bak bütün kategorileri tekrar etmeyecek şekilde bana listele.
-- group by yaptığımızda her bir grup için arka planda bir tablo oluşturuluyormuş gibi düşünebilirz.
select CategoryID from Products group by CategoryID

-- Her kategoride kaç ürün var? 2. kolon içinde group by yapılabilir.
select CategoryID, count(*) from Products group by CategoryID

-- Ürün sayısı 10'dan az olan kategorileri listele.
select CategoryID, count(*) from Products group by CategoryID having count(*) < 10

-- Fiyatı 20'den fazla olan ürünleri CategoryID'e göre grupla her bir grupta 10'dan az olanları listele.
select CategoryID, count(*) from Products where Price > 20 group by CategoryID having count(*) < 10

/* Ürünlerle kategorilerin birleşimini getir. inner join ile birleştirme yaparız. on durumunda, şartında demek yani biz bun
ları bir araya getireceğiz ama neye göre getireceğiz? O yüzden on kullanıyoruz. Products tablosundaki CategoryID ve  
categories tablosundaki CategoryID'ine göre getir yani onlar eşitse onları yan yana getir demek. inner join sadece iki
tabloda eşleşenleri bir araya getirir eşleşmeyen data varsa onu getirmez. */
select * from Products inner join Categories on Products.CategoryID = Categories.CategoryID

select Products.ProductID, Products.ProductName, Products.Price, Categories.CategoryName 
from Products inner join Categories on Products.CategoryID = Categories.CategoryID

select Products.ProductID, Products.ProductName, Products.Price, Categories.CategoryName 
from Products inner join Categories on Products.CategoryID = Categories.CategoryID where Products.Price > 10

/* Mesela isimlendirme olarak OrderDetails yerine order details yazsaydık [order details] diye yamamız gerekecekti. Çünkü
boşluk olduğu için iki farklı kodmuş gibi algılamasın diye. inner joinlerde alias kullanılacaksa kısaltma kullanılır. 
inner join sadece eşleşen kayıtları getirir. */
select * from Products pr inner join OrderDetails od on pr.ProductID = od.ProductID

-- left join ise yazıma göre solda olup sağda olmayanlarıda getir demek.
select * from Products pr left join OrderDetails od on pr.ProductID = od.ProductID

select * from Customers cu left join orders o on cu.CustomerID = o.CustomerID 

/* Mesela sana özel ilk siparişte %10 indirim datası. null is ile gösterilir. Buradaki null siparişlerde gelmeyen datamız
bunu primary key'e uygularız. right join ise sağda olup solda olmayanlarıda getir demek. */
select * from Customers cu left join orders o on cu.CustomerID = o.CustomerID where o.CustomerID is null

-- Birden fazla tabloyu join etmek istersek.
select * from Products pr left join OrderDetails od on pr.ProductID = od.ProductID inner join orders ord on  
ord.OrderID = od.OrderID
