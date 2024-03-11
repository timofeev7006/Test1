///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

&НаКлиенте
Перем ОбновитьИнтерфейс;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	РазделениеВключено = ОбщегоНазначения.РазделениеВключено();
	
	ПодсистемаСуществуетОбменДанными         = ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ОбменДанными");
	ПодсистемаСуществуетДатыЗапретаИзменения = ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ДатыЗапретаИзменения");
	
	УстановитьВидимость();
	УстановитьДоступность();
	
	НастройкиПрограммыПереопределяемый.СинхронизацияДанныхПриСозданииНаСервере(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	ОбработчикОповещений(ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	ОбновитьИнтерфейсПрограммы();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьСинхронизациюДанныхПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогСообщенийОбменаДаннымиДляWindowsПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогСообщенийОбменаДаннымиДляLinuxПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НастройкиСинхронизацииДанных(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ОбменДанными") Тогда
		МодульОбменДаннымиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ОбменДаннымиКлиент");
		МодульОбменДаннымиКлиент.ОткрытьНастройкиСинхронизацииДанных();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НастроитьДатыЗапретаЗагрузки(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ДатыЗапретаИзменения") Тогда
		МодульДатыЗапретаИзмененияСлужебныйКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ДатыЗапретаИзмененияСлужебныйКлиент");
		МодульДатыЗапретаИзмененияСлужебныйКлиент.ОткрытьДатыЗапретаЗагрузкиДанных(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьПрефиксИБ(Команда)
	
	ПараметрыФормы = Новый Структура("Префикс", НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы);
	
	ОткрытьФорму("Обработка.ПомощникСозданияОбменаДанными.Форма.ИзменениеПрефиксаУзлаИБ",ПараметрыФормы,,,,,, 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

// Обработка оповещений от других открытых форм.
//
// Параметры:
//   ИмяСобытия - Строка - имя события. Может быть использовано для идентификации сообщений принимающими их формами.
//   Параметр - Произвольный - параметр сообщения. Могут быть переданы любые необходимые данные.
//   Источник - Произвольный - источник события. Например, в качестве источника может быть указана другая форма.
//
// Пример:
//   Если ИмяСобытия = "НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы" Тогда
//     НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы = Параметр;
//   КонецЕсли;
//
&НаКлиенте
Процедура ОбработчикОповещений(ИмяСобытия, Параметр, Источник)
	
	
	
КонецПроцедуры

&НаКлиенте
Процедура УдалениеПредупрежденийСинхронизацииДанных(Команда)
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("МассивУзловПланаОбмена", Новый Массив);
	ПараметрыОткрытия.Вставить("ОтборПоДатеВозникновения", Новый СтандартныйПериод);
	ПараметрыОткрытия.Вставить("ОтборУзловОбменов", Новый Массив);
	ПараметрыОткрытия.Вставить("ОтборТипыПредупреждений", Новый Массив); 
	ПараметрыОткрытия.Вставить("ТолькоСкрытыеЗаписи", Ложь);
	
	ОткрытьФорму("РегистрСведений.РезультатыОбменаДанными.Форма.УдалениеУстаревшихПредупреждений", ПараметрыОткрытия, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// Клиент

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	ИмяКонстанты = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	ОбновитьПовторноИспользуемыеЗначения();
	
	Если ОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;
	
	Если ИмяКонстанты <> "" Тогда
		Оповестить("Запись_НаборКонстант", Новый Структура, ИмяКонстанты);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбщегоНазначенияКлиент.ОбновитьИнтерфейсПрограммы();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьРазрешенияПрофилейБезопасности(Элемент)
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ОбновитьРазрешенияПрофилейБезопасностиЗавершение", ЭтотОбъект, Элемент);
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		
		МассивЗапросов = СоздатьЗапросНаИспользованиеВнешнихРесурсов(Элемент.Имя);
		
		Если МассивЗапросов = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
		МодульРаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(
			МассивЗапросов, ЭтотОбъект, ОповещениеОЗакрытии);
	Иначе
		ВыполнитьОбработкуОповещения(ОповещениеОЗакрытии, КодВозвратаДиалога.ОК);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция СоздатьЗапросНаИспользованиеВнешнихРесурсов(ИмяКонстанты)
	
	КонстантаМенеджер = Константы[ИмяКонстанты];
	КонстантаЗначение = НаборКонстант[ИмяКонстанты];
	
	Если КонстантаМенеджер.Получить() = КонстантаЗначение Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если ИмяКонстанты = "ИспользоватьСинхронизациюДанных" Тогда
		
		МодульОбменДаннымиСервер = ОбщегоНазначения.ОбщийМодуль("ОбменДаннымиСервер");
		Если КонстантаЗначение Тогда
			Запрос = МодульОбменДаннымиСервер.ЗапросНаИспользованиеВнешнихРесурсовПриВключенииОбмена();
		Иначе
			Запрос = МодульОбменДаннымиСервер.ЗапросНаОчисткуРазрешенийИспользованияВнешнихРесурсов();
		КонецЕсли;
		Возврат Запрос;
		
	Иначе
		
		МенеджерЗначения = КонстантаМенеджер.СоздатьМенеджерЗначения();
		ИдентификаторКонстанты = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(МенеджерЗначения.Метаданные());
		
		МодульРаботаВБезопасномРежиме = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежиме");
		Если ПустаяСтрока(КонстантаЗначение) Тогда
			
			Запрос = МодульРаботаВБезопасномРежиме.ЗапросНаОчисткуРазрешенийИспользованияВнешнихРесурсов(ИдентификаторКонстанты);
			
		Иначе
			
			Разрешения = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(
				МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеКаталогаФайловойСистемы(КонстантаЗначение, Истина, Истина));
			Запрос = МодульРаботаВБезопасномРежиме.ЗапросНаИспользованиеВнешнихРесурсов(Разрешения, ИдентификаторКонстанты);
			
		КонецЕсли;
		
		Возврат ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Запрос);
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ОбновитьРазрешенияПрофилейБезопасностиЗавершение(Результат, Элемент) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
	
		Подключаемый_ПриИзмененииРеквизита(Элемент);
		
	Иначе
		
		Прочитать();
	
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вызов сервера

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	ИмяКонстанты = СохранитьЗначениеРеквизита(РеквизитПутьКДанным);
	УстановитьДоступность(РеквизитПутьКДанным);
	ОбновитьПовторноИспользуемыеЗначения();
	Возврат ИмяКонстанты;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Сервер

&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным)
	
	ЧастиИмени = СтрРазделить(РеквизитПутьКДанным, ".");
	Если ЧастиИмени.Количество() <> 2 Тогда
		Возврат "";
	КонецЕсли;
	
	ИмяКонстанты = ЧастиИмени[1];
	КонстантаМенеджер = Константы[ИмяКонстанты];
	КонстантаЗначение = НаборКонстант[ИмяКонстанты];
	
	Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
		КонстантаМенеджер.Установить(КонстантаЗначение);
	КонецЕсли;
	
	Возврат ИмяКонстанты;
	
КонецФункции

&НаСервере
Процедура УстановитьВидимость()
	
	Если РазделениеВключено Тогда
		Элементы.ОписаниеРаздела.Заголовок = НСтр("ru = 'Синхронизация данных с моими приложениями.'");
	КонецЕсли;
	
	Если ПодсистемаСуществуетОбменДанными Тогда
		МассивДоступныхВерсий = Новый Соответствие;
		МодульОбменДаннымиПереопределяемый = ОбщегоНазначения.ОбщийМодуль("ОбменДаннымиПереопределяемый");
		МодульОбменДаннымиПереопределяемый.ПриПолученииДоступныхВерсийФормата(МассивДоступныхВерсий);
		
		Элементы.ГруппаЗагрузкаДанныхEnterpriseData.Видимость = ?(МассивДоступныхВерсий.Количество() = 0, Ложь, Истина);
		
		Элементы.ГруппаПрефиксУзлаРаспределеннойИнформационнойБазы.РасширеннаяПодсказка.Заголовок =
			Метаданные.Константы.ПрефиксУзлаРаспределеннойИнформационнойБазы.Подсказка;
			
		Если РазделениеВключено Тогда
			Элементы.ГруппаИспользоватьСинхронизациюДанных.Видимость   = Ложь;
			Элементы.ГруппаВременныеКаталогиКластераСерверов.Видимость = Ложь;
			
			Элементы.ПрефиксУзлаРаспределеннойИнформационнойБазы.Заголовок = НСтр("ru = 'Префикс в этой программе'");
			
			Элементы.ГруппаОценкаПроизводительности.Видимость = Ложь;
		Иначе
			Элементы.ГруппаВременныеКаталогиКластераСерверов.Видимость = Не ОбщегоНазначения.ИнформационнаяБазаФайловая()
				И Пользователи.ЭтоПолноправныйПользователь(, Истина);
		КонецЕсли;
	Иначе
		Элементы.ГруппаСинхронизацияДанных.Видимость = Ложь;
		Элементы.ГруппаПрефиксУзлаРаспределеннойИнформационнойБазы.Видимость = Ложь;
		Элементы.ГруппаСинхронизацияДанныхДополнительно.Видимость  = Ложь;
		Элементы.ГруппаВременныеКаталогиКластераСерверов.Видимость = Ложь;
	КонецЕсли;
	
	Если ПодсистемаСуществуетДатыЗапретаИзменения Тогда
		МодульДатыЗапретаИзмененияСлужебный = ОбщегоНазначения.ОбщийМодуль("ДатыЗапретаИзмененияСлужебный");
		СвойстваРазделов = МодульДатыЗапретаИзмененияСлужебный.СвойстваРазделов();
		
		Элементы.ГруппаДатыЗапретаЗагрузки.Видимость = СвойстваРазделов.ДатыЗапретаЗагрузкиВнедрены;
		
		Если РазделениеВключено
			И СвойстваРазделов.ДатыЗапретаЗагрузкиВнедрены Тогда
			Элементы.ИспользоватьДатыЗапретаЗагрузки.РасширеннаяПодсказка.Заголовок =
				НСтр("ru = 'Запрет загрузки данных прошлых периодов из других приложений.
				           |Не влияет на загрузку данных из автономных рабочих мест.'");
		КонецЕсли;
	Иначе
		Элементы.ГруппаДатыЗапретаЗагрузки.Видимость = Ложь;
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступность(РеквизитПутьКДанным = "")
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьДатыЗапретаЗагрузки"
			Или РеквизитПутьКДанным = "")
		И ПодсистемаСуществуетДатыЗапретаИзменения Тогда
		
		Элементы.НастроитьДатыЗапретаЗагрузки.Доступность = НаборКонстант.ИспользоватьДатыЗапретаЗагрузки;
			
	КонецЕсли;
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьОценкуПроизводительностиСинхронизацииДанных"
			Или РеквизитПутьКДанным = "")  Тогда
		
		Элементы.СеансыОбменов.Доступность = НаборКонстант.ИспользоватьОценкуПроизводительностиСинхронизацииДанных;
			
	КонецЕсли;
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьСинхронизациюДанных"
			Или РеквизитПутьКДанным = "")
		И ПодсистемаСуществуетОбменДанными Тогда
		
		Элементы.НастройкиСинхронизацииДанных.Доступность            = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.ГруппаДатыЗапретаЗагрузки.Доступность               = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.РезультатыСинхронизацииДанных.Доступность           = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.ГруппаВременныеКаталогиКластераСерверов.Доступность = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.ГруппаОценкаПроизводительности.Доступность          = НаборКонстант.ИспользоватьСинхронизациюДанных;
		
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти
