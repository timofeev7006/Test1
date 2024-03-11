#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура ПриОпределенииНастроекПечати(НастройкиОбъекта) Экспорт	
	НастройкиОбъекта.ПриДобавленииКомандПечати = Истина;
КонецПроцедуры

Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	// Анкета клиента
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "АнкетаКлиента";
	КомандаПечати.Представление = НСтр("ru = 'Анкета клиента'");
	КомандаПечати.Порядок = 5;
	
	// Товарная накладная
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "ТоварнаяНакладная";
	КомандаПечати.Представление = НСтр("ru = 'Товарная накладная'");
	КомандаПечати.Порядок = 10;
	
	// Комплект документов
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "АнкетаКлиента,ТоварнаяНакладная";
	КомандаПечати.Представление = НСтр("ru = 'Комплект документов'");
	КомандаПечати.Порядок = 20;
	
	// Товарная накладная
	КомандаПечати = КомандыПечати.Добавить();
	Командапечати.МенеджерПечати = "УправлениеПечатью";
	КомандаПечати.Идентификатор = "Документ.Дораб_Доставка.ПФ_DOC_ДоговорДоставкиВорд";
	КомандаПечати.Представление = НСтр("ru = 'Договор доставки'");
	КомандаПечати.Порядок = 30;
	
КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	ПечатнаяФорма = УправлениеПечатью.СведенияОПечатнойФорме(КоллекцияПечатныхФорм, "АнкетаКлиента");
	Если ПечатнаяФорма <> Неопределено Тогда
		ПечатнаяФорма.ТабличныйДокумент = ПечатьАнкеты(МассивОбъектов, ОбъектыПечати);
		ПечатнаяФорма.СинонимМакета = НСтр("ru = 'Анкета клиента'");
		ПечатнаяФорма.ПолныйПутьКМакету = "Документ.Дораб_Доставка.АнкетаКлиента";
	КонецЕсли;
	
	ПечатнаяФорма = УправлениеПечатью.СведенияОПечатнойФорме(КоллекцияПечатныхФорм, "ТоварнаяНакладная");
	Если ПечатнаяФорма <> Неопределено Тогда
		ПечатнаяФорма.ТабличныйДокумент = ПечатьТоварнойНакладной(МассивОбъектов, ОбъектыПечати);
		ПечатнаяФорма.СинонимМакета = НСтр("ru = 'Товарная накладная'");
		ПечатнаяФорма.ПолныйПутьКМакету = "Документ.Дораб_Доставка.ПФ_MXL_ТоварнаяНакладная";
	КонецЕсли;
	
		
КонецПроцедуры





#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПечатьАнкеты(МассивОбъектов, ОбъектыПечати)
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.Дораб_Доставка.ПФ_MXL_АнкетаКлиента");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Дораб_Доставка.Ссылка КАК Ссылка,
	|	Дораб_Доставка.Дата,
	|	Дораб_Доставка.Номер
	|ИЗ
	|	Документ.Дораб_Доставка КАК Дораб_Доставка
	|ГДЕ
	|	Дораб_Доставка.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", МассивОбъектов);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	Вопросы = Макет.ПолучитьОбласть("Вопросы");
	ТабДок = Новый ТабличныйДокумент;

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		НомерСтрокиНачало = ТабДок.ВысотаТаблицы + 1;

		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		
		ДанныеQRКода = ГенерацияШтрихкода.ДанныеQRКода(ПолучитьНавигационнуюСсылку(Выборка.Ссылка), 1, 120);
		
		Если НЕ ТипЗнч(ДанныеQRКода) = Тип("ДвоичныеДанные") Тогда
			ТекстСообщения = НСтр("ru = 'Не удалось сформировать QR-код.
			|Технические подробности см. в журнале регистрации.'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		Иначе
			КартинкаКода = Новый Картинка(ДанныеQRКода);
			Шапка.Рисунки.ШтрихКод.Картинка = КартинкаКода
		КонецЕсли;

		
		ТабДок.Вывести(Шапка, Выборка.Уровень());
		
		ТабДок.Вывести(Вопросы);
		
		ВставлятьРазделительСтраниц = Истина;
		
		// В табличном документе необходимо задать имя области, в которую был 
		// выведен объект. Нужно для возможности печати комплектов документов.
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабДок, 
		НомерСтрокиНачало, ОбъектыПечати, Выборка.Ссылка);	
	КонецЦикла;
	Возврат ТабДок;
КонецФункции

Функция ПечатьТоварнойНакладной(МассивОбъектов, ОбъектыПечати)
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.Дораб_Доставка.ПФ_MXL_ТоварнаяНакладная");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Дораб_Доставка.Ссылка КАК Ссылка,
	|	Дораб_Доставка.Дата,
	|	Дораб_Доставка.Контрагент,
	|	Дораб_Доставка.Номер,
	|	Дораб_Доставка.Организация,
	|	Дораб_Доставка.Товары.(
	|		НомерСтроки,
	|		Номенклатура,
	|		Количество
	|	)
	|ИЗ
	|	Документ.Дораб_Доставка КАК Дораб_Доставка
	|ГДЕ
	|	Дораб_Доставка.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", МассивОбъектов);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьТоварыШапка = Макет.ПолучитьОбласть("ТоварыШапка");
	ОбластьТовары = Макет.ПолучитьОбласть("Товары");
	ОбластьПодвал = Макет.ПолучитьОбласть("Подвал");
	ТабДок = Новый ТабличныйДокумент;


	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		НомерСтрокиНачало = ТабДок.ВысотаТаблицы + 1;
		
		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		
		ДанныеQRКода = ГенерацияШтрихкода.ДанныеQRКода(ПолучитьНавигационнуюСсылку(Выборка.Ссылка), 1, 120);
		
		Если НЕ ТипЗнч(ДанныеQRКода) = Тип("ДвоичныеДанные") Тогда
			ТекстСообщения = НСтр("ru = 'Не удалось сформировать QR-код.
			|Технические подробности см. в журнале регистрации.'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		Иначе
			КартинкаКода = Новый Картинка(ДанныеQRКода);
			Шапка.Рисунки.ШтрихКод.Картинка = КартинкаКода
		КонецЕсли;
		
		
		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ТабДок.Вывести(ОбластьТоварыШапка);
		ВыборкаТовары = Выборка.Товары.Выбрать();
		Пока ВыборкаТовары.Следующий() Цикл
			ОбластьТовары.Параметры.Заполнить(ВыборкаТовары);
			ТабДок.Вывести(ОбластьТовары, ВыборкаТовары.Уровень());
		КонецЦикла;
		
		ТабДок.Вывести(ОбластьПодвал);

		ВставлятьРазделительСтраниц = Истина;
		
		// В табличном документе необходимо задать имя области, в которую был 
		// выведен объект. Нужно для возможности печати комплектов документов.
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабДок, 
		НомерСтрокиНачало, ОбъектыПечати, Выборка.Ссылка);
	КонецЦикла;
	Возврат ТабДок;
КонецФункции

#КонецОбласти

#КонецЕсли
