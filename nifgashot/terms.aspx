<%@ Page Language="C#" Title="תקנון ותנאי שימוש באתר ניפגשות" MasterPageFile="/masters/mainMaster.master" Inherits="MainCulture" %>

<script runat="server">
    protected void Page_Load(object sender, System.EventArgs e)
    {
        HtmlHead head = Page.Header;
        HtmlMeta metaDescription = new HtmlMeta();
        metaDescription.Name = "description";
        metaDescription.Content = populateClassFromDB.GetSiteMessagesByKey("termsOfUse");
        head.Controls.Add(metaDescription);

        if (Session["Language2"].ToString() == "HE")
        {
            hebtrm.Visible = true;
            engtrm.Visible = false;
        }
        if (Session["Language2"].ToString() == "EN")
        {
            hebtrm.Visible = false;
            engtrm.Visible = true;
        }
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            MasterPageFile = "/masters/mainMaster.master";
            Theme = "nifgashot";
        }
        else
        {
            MasterPageFile = "/masters/mainMaster.master";
            Theme = "nifgashot";
        }
        var domainList_ = populateClassFromDB.PopulateDomainsList();
        Tools.InitializeCulture(domainList_);
    }

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel runat="server" ID="hebtrm">
        <div class="reg flotTo">
            <div class="reg">
                <h2><%=populateClassFromDB.GetSiteMessagesByKey("termsOfUse") %></h2>
                <p>
                    המסמך מנוסח בלשון זכר מטעמי נוחות בלבד והוא מתייחס באופן שווה לשני המינים. כל האמור
                בלשון זכר, כוחו יפה גם בלשון נקבה. באמצעות כניסה לאתר זה אתה מקבל על עצמך את התנאים
                הבאים: האתר מכיל תוכן למבוגרים אשר עלול להיות פוגע ואף לא חוקי עבור משתמשים מסוימים
                ו/או במדינות מסויימות. אם אתה מרגיש שאתה
                פגיע או יכול להיפגע מתוכן זה אל תיכנס לאתר. האתר מיועד
                למבוגרים מעל גיל 18. אם אתה מתחת לגיל 18, עלול להיפגע מתוכן בעל אופי מיני, או גולש
                ממקום בו אסורה צפייה באתרים מעין זה, בין אם בתקנון או בין אם בחוק, אל תיכנס לאתר.
                האתר הוא אתר אירוח בידורי אשר לא מיועד למטרות קידום אינטרסים של נפגשות אינטנסיבי. מפעילי
                האתר אינם אחראים על המידע המוצג בו. התוכן המוצג באתר לא מעיד על סוג של הסכמה או
                עידוד לפעילות מסויימת מצד מפעילי האתר. על מנת להגן על המשתמשים מלצפות בתוכן ללא
                הסכמתם, האתר מבקש ממך לקרוא ולאשר את הדברים הבאים.<br />
                    <br />
                    שים לב : אל תמשיך לקרוא אלא אם אתה בטוח שאינך מפר חוקים או תקנות הקשורים בצפייה
                בתכנים למבוגרים.<br />
                    <br />
                    ע"י קבלה ואישור של ההסכם הנ"ל הינך מאשר את הבאים:<br />
                    <br />
                </p>
                <ul>
                    <li>אני בן 18 שנים או מבוגר יותר.</li>
                    <li>התוכן בו אני צופה או אותו אני רוכש הוא לשימוש אישי בלבד, לעולם לא אחשוף קטין לתוכן
                        מסוג זה.</li>
                    <li>כמבוגר אני מאמין שיש לי זכות אישית לקרוא, לצפות ולרכוש כל סוג של תוכן ושהתוכן המוצג
                        באתר זה אינו פוגע ,מגונה או מעליב וגם לא יכול להיות מובן כפוגע מגונה או מעליב אי
                        פעם.</li>
                    <li>צפייה, הורדה, קריאה או שימוש בתוכן שמופיע באתר לא פוגע או מפר שום תקנה בכל צורת
                        יישוב (מדינה,עיר, כפר, קיבוץ,מושב,עיירה,רחוב וכיו"ב) או מוסד חינוכי או מקום עבודה
                        להם אני קשור.</li>
                    <li>מפעילי האתר אינם אחראים לכל מידע שגוי,שקרי, שנוי במחלוקת, או לא חוקי ולא אחראים
                        גם להשלכות החוקיות שמידע כזה עלול לגרור עקב צפייה, קריאה הורדה או צפייה בתוכן אשר
                        מוצג באתר זה. אתר זה והקשורים אליו לא יוכלו להימצא אחראים לכל השלכה משפטית אשר עלולה
                        לצוץ כתוצאה ממידע מוטעה או שנוי במחלוקת אשר הוכנס או נעשה בו שימוש באתר זה או בכל
                        חומר שמקורו באתר זה.</li>
                    <li>אני מכיר ומסכים שהוספת קישור ,פרסומת ,תוכן או מידע מסוג כלשהו בכל מקום באתר ללא
                        אישור ממפעילי האתר מראש ובכתב - הינו אסור בתכלית ועלול לגרום להפרת זכויות וכתוצאה
                        מכך לנקיטת הליכים משפטיים.</li>
                    <li>אני מסכים לכך שאסור לי להקליט את המסך/מצלמה/מלל או כל תוכן נוסף שמופיע באתר ללא
                        אישור בכתב ממפעילי האתר. </li>
                    <%--<li>לאתר זה הזכות הבלעדית לעקוב/לשמור/לבדוק את ההתנהלות בין הלקוחות לבין העובדים/ות
                        באתר.</li>--%>
                    <%--<li>אני מסכים לכך שאסור לי לשדל את העובדים/לקוחות לקיום יחסי מין או למפגשים. </li>--%>
                    <li>אני מסכים לכך שהאתר משמש אותי רק למטרות הנאה ולא למטרות עיסקיות/ריגול תעשייתי.
                    </li>
                    <li>אני מסכים לכך שאסור לי "לסחוט" את משדרות/לקוחות בדרך כלשהי ובמידה ואעשה כך פרטי
                        יועברו לרשויות החוק. </li>
                    <li>אני מתחייב שאין לי כל רצון לגרום לנזק כלשהוא כולל נזק כלכלי,עיסקי,מיסחרי,מוסרי ועוד..
                        למפעילי האתר, עובדיו או משתמשים אחרים. </li>
                    <li>הנני נושא באחריות לכל הפעולות המתבצעות בשם המשתמש והסיסמה האישית שלי. מפעילי האתר
                        ממליצים לא למסור את הסיסמה האישית שבעזרתה אני מזדהה באתר, או כל מידע הקשור עם אופן
                        ההתחברות שלי לאתר לכל לצד שלישי אחר כלשהו. אם אבחר לחלוק מידע זה עם צדדים שלישיים
                        כלשהם, אני בלבד אשא באחריות לכל הפעולות שיתבצעו בשם המשתמש והסיסמה האישית שלי. במקרה
                        שאאבד שליטה על הסיסמה שלי, אאבד שליטה מהותית על המידע המזוהה האישי שלי, ואהיה כפוף
                        לפעולות מחייבות מבחינה חוקית שיתבצעו בשמי. הנני מודע לכך שאם הסיסמה שלי אינה בטוחה
                        מכל סיבה שהיא, עלי לשנותה לאלתר. </li>
                    <li>אתר זה נוקט בסטנדרטים הנהוגים בתעשייה להבטחת הסודיות של המידע האישי המזוהה על ידי
                        הגולשים, לרבות "firewalls". אתר זה מתייחסת למידע כאל משאב החייב בהגנה מפני אובדן
                        וגישה בלתי מורשית. בחברת אתר זה משתמשים בשיטות אבטחה שונות להגנה על מידע שכזה מפני
                        גישה בלתי מורשית בידי גורמים בתוך החברה ומחוצה לה. יובהר כי מפעילי האתר יפעלו ככל
                        אשר יוכלו על מנת להגן על המידע אשר נמצא במאגר המידע שברשותם, אולם, ומבלי לפגוע בכלליות
                        האמור לעיל, מפעילי האתר לא יישאו באחריות למאגר המידע מעבר להגנה אליה הם מחוייבים
                        בכפוף לדין הישראלי ומעבר להגנה סבירה בנסיבות העניין. </li>
                    <li>אתר זה משתף פעולה עם חקירות של רשויות אכיפת החוק, וכן עם צדדים שלישיים אחרים לצורך
                        אכיפת חוקים, כמו: זכויות קניין רוחני, זכויות קניין, הונאה וזכויות אחרות. כמו כן,
                        רשאים בלעי אתר זה למסור כל מידע אודות המשדרות/לקוחות לרשויות אכיפת החוק ולכל רשויות
                        ממשל אחרות, בכפוף לצו בית משפט, וכפי שמתחייב מלשון חוק הגנת הפרטיות תשמ"א - 1981,
                        לצורך חקירת הונאה, הפרת זכויות קניין רוחני, או פעילות בלתי חוקית אחרת, או כזו העלולה
                        לחשוף אתר זה או את המשדרות/לקוחות לאחריות משפטית. </li>
                    <li>אמצעי התשלום שבעזרתו אני מבצע את הרכישות חייב להיות בבעלותי או לחילופין עלי לקבל
                        אישור מבעל אמצעי התשלום .</li>
                    <li>ידוע לי כי במידה ואשתמש באמצעי תשלום שאינם שלי (ללא רשות) ובעל אמצעי התשלום/חברת
                        האשראי יפנה/תפנה לאתר זה לקבלת פרטים, אתר זה יעביר להם את כל המידע שברשותו לגבי
                        עסקאות אלו .</li>
                    <%--	<li>אני מתחייב שלא להציע לעובדי האתר כל הצעת עבודה או לשדל להצעת עבודה אחרת .</li>--%>
                    <li>התקנון ניתן לשינוי בכל עת ע"י ידי מפעילי האתר ועפ"י שיקול דעתם.</li>
                </ul>
                <br />
                <p>
                    דף התקנון מכונן הסכם משפטי בין האתר ובין משדר/ת/לקוח, וגם בין האתר ובין כל גוף עסקי
                אשר יש משדר/ת/לקוח אינטרס או חבות משפטית או עסקית כלפיו. אם חלק כלשהוא מההסכם יקבע
                כבלתי ניתן לאכיפה ע"י סמכות משפטית חוקית, אזי שאר ההסכם לא יושפע כתוצאה מהחלטה זו.<br />
                    ההסכם רשום בעברית ואינו ניתן לפירוש ע"י צד שלישי, לא תתקבל כל פרשנות של ההסכם או
                כל תביעה שתבסס על הבנה לא נכונה של התקנון כתוצאה מתרגום לשפה אחרת.<br />
                    מקום השיפוט הבלעדי בכל עניין ומחלוקת בכל הנוגע לשירותים באתר, יהיה בית המשפט המוסמך
                בסופיה, אשר ידון בעניין בהתאם לדיני בולגריה.
                <br />
                    <br />
                </p>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="engtrm" Visible="False">
        <div class="reg flotTo">
            <div class="fullpage">
                <div style="margin: 10px 10px 10px 20px; width: 900px; float: left; text-align: left">
                    <br>
                    <div class="WordSection1">
                        <p class="MsoNormal" align="left" style="margin-top: 4.8pt; margin-right: 0cm; margin-bottom: 6.0pt; margin-left: 0cm; text-align: center; line-height: 150%; background: white">
                            <b><span style="font-size: 10.0pt; line-height: 150%; color: black">NEWCAM18</span></b>
                        </p>
                        <p class="MsoNormal" align="left" style="margin-top: 4.8pt; margin-right: 0cm; margin-bottom: 6.0pt; margin-left: 0cm; text-align: center; line-height: 150%; background: white">
                            <b><span style="font-size: 16.0pt; line-height: 150%; color: black">TERMS AND CONDITIONS
                                OF SERVICE</span></b>
                        </p>
                        <p class="MsoNormal">
                            &nbsp;
                        </p>
                        <p class="MsoNormal">
                            Please read the following Terms &amp; Conditions carefully
                        </p>
                        <p class="MsoNormal">
                            By entering and using the NEWCAM18 website you agree to be bound by the Terms
                            and Conditions as set forth below. These terms and condition are a binding, enforceable
                            legal agreement.
                        </p>
                        <p class="MsoNormal">
                            1. Definitions.
                        </p>
                        <p class="MsoNormal">
                            "NEWCAM18" is an interactive adult website providing original live entertainment
                            for transmission and broadcast over the Internet, consisting of information, services
                            and content as provided by NEWCAM18 affiliates and other third parties. "Subscriber"
                            means each person who either actively registers to NEWCAM18 and establishes or
                            passively accesses a connection ("Account") for access to and use of any of the
                            services at NEWCAM18 (the “Service”).
                        </p>
                        <p class="MsoNormal">
                            2. General.
                        </p>
                        <p class="MsoNormal">
                            (A) You represent to NEWCAM18 that you are eighteen or over to register as a member
                            of or to use the Service. Membership in the Service is void where prohibited by
                            law. By using and/or viewing this site, you represent and warrant that you have
                            the right, authority, and capacity to enter into this agreement and to abide by
                            all of the terms and conditions of this agreement and that you are at least eighteen
                            (18) years of age (or 21 years old in any location where 18 is not the age of majority)
                            and that you are specifically interested in and wish to have free and/or paid access
                            to visual images, verbal and written descriptions, and audio sounds of a sexually-oriented
                            materials. The materials that are available within this site may include graphic
                            visual depictions and descriptions of nudity and sexual activity and should not
                            be accessed by anyone who is younger than eighteen (18) years old (or 21 years old
                            where 18 is not the age of majority) or who is offended by such materials or who
                            does not wish to be exposed to such materials.
                        </p>
                        <p class="MsoNormal">
                            (B) By registering, using and/or viewing this site, either actively or passively,
                            you represent and warrant the following: i) that you will not permit any person(s)
                            under eighteen (18) years of age (or 21 years where 18 is not the age of majority)
                            to have access to any of the materials contained within this site, ii) That you
                            understand that when you gain access to this site, you will be exposed to visual
                            images, verbal descriptions and audio sounds of a sexually oriented which may include
                            graphic visual depictions and descriptions of nudity and sexual activity. You are
                            voluntarily choosing to do so, because you want to view, read and/or hear the various
                            materials which are available, for your own personal enjoyment, information and/or
                            education, iii)you further represent and warrant that you are familiar with the
                            standards in your community regarding the acceptance of such sexually-oriented materials
                            and the materials you expect to encounter are within those standards, iv) that you
                            further represent and warrant that you have not notified any governmental agency,
                            including the U.S. postal service, that you do not wish to receive sexually oriented
                            material, v) that you represent and warrant that you have not and will not use and/or
                            view the Service in a restricted place, country, or location in which doing so would,
                            or could be deemed a violation of any law.
                        </p>
                        <p class="MsoNormal">
                            (C) This Agreement, which incorporates by reference other provisions applicable
                            to the use of NEWCAM18, including, but not limited to, supplemental terms and
                            conditions set forth in paragraph 14 hereof ("Supplemental Terms") governing the
                            use of certain specific material contained in newcam18, sets forth the terms and
                            conditions that apply to use of newcam18 by Subscriber. By using newcam.biz (other
                            than to read this Agreement for the first time), Subscriber agrees to comply with
                            all of the terms and conditions hereof. The right to use newcam18 is personal
                            to Subscriber and is not transferable to any other person or entity. Subscriber
                            is responsible for all use of Subscriber's Account (under any given name, screen
                            name or password) and for ensuring that all use of Subscriber's Account complies
                            fully with the provisions of this Agreement. Subscriber shall be responsible for
                            protecting the confidentiality of Subscriber's password(s), if any.
                        </p>
                        <p class="MsoNormal">
                            (D) newcam18 shall have the right at any time to change or discontinue any aspect
                            or feature of newcam18, including, but not limited to, content, hours of availability,
                            and equipment needed for access or use.
                        </p>
                        <p class="MsoNormal">
                            3. Changed Terms.
                        </p>
                        <p class="MsoNormal">
                            newcam18 shall have the right at any time to change or modify the terms and conditions
                            applicable to Subscriber's use of newcam18, or any part thereof, or to impose
                            new conditions, including, but not limited to, adding fees and charges for use.
                            Such changes, modifications, additions or deletions shall be effective immediately
                            upon notice thereof, which may be given by means including, but not limited to,
                            posting on newcam18, or by electronic or conventional mail, or by any other means
                            by which Subscriber obtains notice thereof. Any use of newcam18 by Subscriber
                            after such notice shall be deemed to constitute acceptance by Subscriber of such
                            changes, modifications or additions.
                        </p>
                        <p class="MsoNormal">
                            4. Equipment.
                        </p>
                        <p class="MsoNormal">
                            Subscriber shall be responsible for obtaining and maintaining all telephone, computer
                            hardware and other equipment needed for access to and use of newcam18 and all
                            charges related thereto.
                        </p>
                        <p class="MsoNormal">
                            5. Subscriber Conduct.
                        </p>
                        <p class="MsoNormal">
                            (A) Subscriber shall use newcam18 for lawful purposes only. Subscriber shall not
                            post or transmit through newcam18 any material which violates or infringes in
                            any way upon the rights of others, which is unlawful, threatening, abusive, defamatory,
                            invasive of privacy or publicity rights, vulgar, obscene, profane or otherwise objectionable,
                            which encourages conduct that would constitute a criminal offense, give rise to
                            civil liability or otherwise violate any law, or which, without newcam18’s express
                            prior approval, contains advertising or any solicitation with respect to products
                            or services. Any conduct by a “Subscriber” that in newcam18’s discretion restricts
                            or inhibits any other Subscriber from using or enjoying newcam18 will not be permitted.
                            Subscriber shall not use newcam18 to advertise or perform any commercial solicitation,
                            including, but not limited to, the solicitation of users to become subscribers of
                            other on-line services competitive with the newcam18 Service.
                        </p>
                        <p class="MsoNormal">
                        </p>
                        <p class="MsoNormal">
                            (B) newcam18 contains copyrighted material, trademarks and other proprietary information,
                            including, but not limited to, text, software, photos, video, graphics, music and
                            sound, and the entire contents of newcam18 are copyrighted as a collective work
                            under the United States copyright laws. newcam18 owns a copyright in the selection,
                            coordination, arrangement and enhancement of such content, as well as in the content
                            original to it. Subscriber may not modify, publish, transmit, participate in the
                            transfer or sale, create derivative works, or in any way exploit, any of the content,
                            in whole or in part. Subscriber may download copyrighted material for Subscriber's
                            personal use only. Except as otherwise expressly permitted under copyright law,
                            no copying, redistribution, retransmission, publication or commercial exploitation
                            of downloaded material will be permitted without the express permission of newcam18
                            and the copyright owner. In the event of any permitted copying, redistribution or
                            publication of copyrighted material, no changes in or deletion of author attribution,
                            trademark legend or copyright notice shall be made. Subscriber acknowledges that
                            it does not acquire any ownership rights by downloading copyrighted material.
                        </p>
                        <p class="MsoNormal">
                            (C) Subscriber shall not upload, post or otherwise make available on newcam18
                            any material protected by copyright, trademark or other proprietary right without
                            the express permission of the owner of the copyright, trademark or other proprietary
                            right and the burden of determining that any material is not protected by copyright
                            rests with Subscriber. Subscriber shall be solely liable for any damage resulting
                            from any infringement of copyrights, proprietary rights, or any other harm resulting
                            from such a submission. By submitting material to any public or private area of
                            newcam18, Subscriber automatically grants, or warrants that the owner of such
                            material has expressly granted newcam18 the royalty-free, perpetual, irrevocable,
                            non-exclusive right and license to use, reproduce, modify, adapt, publish, translate
                            and distribute such material (in whole or in part) worldwide and/or to incorporate
                            it in other works in any form, media or technology now known or hereafter developed
                            for the full term of any copyright that may exist in such material. Subscriber also
                            permits any other Subscriber to access, view, store or reproduce the material for
                            that Subscriber's personal use. Subscriber hereby grants newcam18 the right to
                            edit, copy, publish and distribute any material made available on newcam18 by
                            Subscriber.
                        </p>
                        <p class="MsoNormal">
                            (D) The foregoing provisions of Section 5 are for the benefit of newcam18, its
                            subsidiaries, affiliates and its third party content providers and licensors and
                            each shall have the right to assert and enforce such provisions directly or on its
                            own behalf.
                        </p>
                        <p class="MsoNormal">
                            6. Disclaimer of Warranty; Limitation of Liability.
                        </p>
                        <p class="MsoNormal">
                            (A) SUBSCRIBER EXPRESSLY AGREES THAT USE OF newcam18 IS AT SUBSCRIBER'S SOLE RISK.
                            NEITHER newcam18, ITS AFFILIATES NOR ANY OF THEIR RESPECTIVE Employees, AGENTS,
                            THIRD PARTY CONTENT PROVIDERS OR LICENSORS WARRANT THAT newcam18 WILL BE UNINTERRUPTED
                            OR ERROR FREE; NOR DO THEY MAKE ANY WARRANTY AS TO THE RESULTS THAT MAY BE OBTAINED
                            FROM USE OF newcam18, OR AS TO THE ACCURACY, RELIABILITY OR CONTENT OF ANY INFORMATION,
                            SERVICE, OR MERCHANDISE PROVIDED THROUGH newcam18.
                        </p>
                        <p class="MsoNormal">
                            (B) newcam18 IS PROVIDED ON AN "AS IS" BASIS WITHOUT WARRANTIES OF ANY KIND, EITHER
                            EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, WARRANTIES OF TITLE OR IMPLIED
                            WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, OTHER THAN THOSE
                            WARRANTIES WHICH ARE IMPLIED BY AND INCAPABLE OF EXCLUSION, RESTRICTION OR MODIFICATION
                            UNDER THE LAWS APPLICABLE TO THIS AGREEMENT.
                        </p>
                        <p class="MsoNormal">
                            (C) THIS DISCLAIMER OF LIABILITY APPLIES TO ANY DAMAGES OR INJURY CAUSED BY ANY
                            FAILURE OF PERFORMANCE, ERROR, OMISSION, INTERRUPTION, DELETION, DEFECT, DELAY IN
                            OPERATION OR TRANSMISSION, COMPUTER VIRUS, COMMUNICATION LINE FAILURE, THEFT OR
                            DESTRUCTION OR UNAUTHORIZED ACCESS TO, ALTERATION OF, OR USE OF RECORD, WHETHER
                            FOR BREACH OF CONTRACT, TORTIOUS BEHAVIOR, NEGLIGENCE, OR UNDER ANY OTHER CAUSE
                            OF ACTION. SUBSCRIBER SPECIFICALLY ACKNOWLEDGES THAT newcam18 OR newcam.biz IS
                            NOT LIABLE FOR THE DEFAMATORY, OFFENSIVE OR ILLEGAL CONDUCT OF OTHER SUBSCRIBERS
                            OR THIRD-PARTIES AND THAT THE RISK OF INJURY FROM THE FOREGOING RESTS ENTIRELY WITH
                            SUBSCRIBER.
                        </p>
                        <p class="MsoNormal">
                            (D) IN NO EVENT WILL newcam.biz, OR ANY PERSON OR ENTITY INVOLVED IN CREATING, PRODUCING
                            OR DISTRIBUTING newcam.biz, BE LIABLE FOR ANY DAMAGES, INCLUDING, WITHOUT LIMITATION,
                            DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL OR PUNITIVE DAMAGES ARISING
                            OUT OF THE USE OF OR INABILITY TO USE newcam.biz. SUBSCRIBER HEREBY ACKNOWLEDGES
                            THAT THE PROVISIONS OF THIS SECTION SHALL APPLY TO ALL CONTENT ON newcam.biz.
                        </p>
                        <p class="MsoNormal">
                            (E) IN ADDITION TO THE TERMS SET FORTH ABOVE NEITHER, newcam.biz, newcam.biz, NOR
                            ITS AFFILIATES, INFORMATION PROVIDERS OR CONTENT PARTNERS SHALL BE LIABLE REGARDLESS
                            OF THE CAUSE OR DURATION, FOR ANY ERRORS, INACCURACIES, OMISSIONS, OR OTHER DEFECTS
                            IN, OR UNTIMELINESS OR UNAUTHENTICITY OF, THE INFORMATION CONTAINED WITHIN newcam.biz,
                            OR FOR ANY DELAY OR INTERRUPTION IN THE TRANSMISSION THEREOF TO THE USER, OR FOR
                            ANY CLAIMS OR LOSSES ARISING THEREFROM OR OCCASIONED THEREBY.
                        </p>
                        <p class="MsoNormal">
                            7. Monitoring.
                        </p>
                        <p class="MsoNormal">
                            newcam.biz shall have the right, but not the obligation, to monitor the content
                            of newcam.biz, including subscriber profiles, chat rooms and forums, to determine
                            compliance with this Agreement and any operating rules established by newcam.biz
                            and to satisfy any law, regulation or authorized government request. newcam.biz
                            shall have the right in its sole discretion to edit, refuse to post or remove any
                            material submitted to or posted on newcam.biz. Without limiting the foregoing, newcam.biz
                            shall have the right to remove any material that newcam.biz, in its sole discretion,
                            finds to be in violation of the provisions hereof or otherwise objectionable.
                        </p>
                        <p class="MsoNormal">
                            8. Indemnification.
                        </p>
                        <p class="MsoNormal">
                            Subscriber agrees to defend, indemnify and hold harmless newcam.biz, newcam.biz,
                            its affiliates and their respective directors, officers, Employees and agents from
                            and against all claims and expenses, including attorneys' fees, arising out of any
                            use of newcam.biz by Subscriber or Subscriber's Account.
                        </p>
                        <p class="MsoNormal">
                            9. Termination.
                        </p>
                        <p class="MsoNormal">
                            Either newcam.biz or Subscriber may terminate this Agreement at any time. Without
                            limiting the foregoing, newcam.biz shall have the right to immediately terminate
                            Subscriber's Account in the event of any conduct by Subscriber which newcam.biz,
                            in its sole discretion, considers to be unacceptable, or in the event of any breach
                            by Subscriber of this Agreement. The provisions of Sections 5(B), 5(C), 5(D), 6,
                            8, 10 and this Section 9 shall survive termination of this Agreement.
                        </p>
                        <p class="MsoNormal">
                            10. Trademarks.
                        </p>
                        <p class="MsoNormal">
                            All other trademarks appearing on newcam.biz are the property of newcam.biz or third
                            party respective owners as noted.
                        </p>
                        <p class="MsoNormal">
                            11. Third Party Content.
                        </p>
                        <p class="MsoNormal">
                            newcam.biz is a distributor (and not a publisher) of content supplied by third parties
                            and Subscribers. Accordingly, newcam.biz has no more editorial control over such
                            content than does a public library, forum, bookstore, or newsstand. Any opinions,
                            advice, statements, services, offers, or other information or content expressed
                            or made available by third parties, including information providers, Subscribers
                            or any other user of newcam.biz, are those of the respective author(s) or distributor(s)
                            and not of newcam.biz. Neither newcam.biz nor any third-party provider of information
                            guarantees the accuracy, completeness, or usefulness of any content, nor its merchantability
                            or fitness for any particular purpose. (Refer to Section 6 above for the complete
                            provisions governing limitation of liabilities and disclaimers of warranty.)
                        </p>
                        <p class="MsoNormal">
                            In many instances, the content available through newcam.biz represents the opinions
                            and judgments of the respective information provider, Subscriber, or other user
                            not under contract with newcam.biz. newcam.biz neither endorses nor is responsible
                            for the accuracy or reliability of any opinion, advice or statement made on newcam.biz
                            by anyone other than authorized newcam.biz employee spokespersons while acting in
                            their official capacities. Under no circumstances will newcam.biz be liable for
                            any loss or damage caused by a Subscriber's reliance on information obtained through
                            newcam.biz. It is the responsibility of Subscriber to evaluate the accuracy, completeness
                            or usefulness of any information, opinion, advice or other content available through
                            newcam.biz. Please seek the advice of professionals, as appropriate, regarding the
                            evaluation of any specific information, opinion, advice or other content.
                        </p>
                        <p class="MsoNormal">
                            12. Miscellaneous.
                        </p>
                        <p class="MsoNormal">
                            This Agreement and any operating rules for newcam.biz established by newcam.biz
                            constitute the entire agreement of the parties with respect to the subject matter
                            hereof, and supersede all previous written or oral agreements between the parties
                            with respect to such subject matter. This Agreement shall be construed in accordance
                            with the <b>laws of the United States,</b> without regard to its conflict of laws
                            rules. No waiver by either party of any breach or default hereunder shall be deemed
                            to be a waiver of any preceding or subsequent breach or default. The section headings
                            used herein are for convenience only and shall not be given any legal import.
                        </p>
                        <p class="MsoNormal">
                            13. Copyrights and Copyright Agent.
                        </p>
                        <p class="MsoNormal">
                            newcam.biz respects the rights of all copyright holders and in this regard, newcam.biz
                            has adopted and implemented a policy that provides for the termination in appropriate
                            circumstances of subscribers and account holders who infringe the rights of copyright
                            holders. If you believe that your work has been copied in a way that constitutes
                            copyright infringement, please provide newcam.biz’s with the following information
                            required by the Online Copyright Infringement Liability Limitation Act of the Digital
                            Millennium Copyright Act, 17 U.S.C. 512:
                        </p>
                        <p class="MsoNormal">
                            1. A physical or electronic signature of a person authorized to act on behalf of
                            the owner of an exclusive right that is allegedly infringed;
                        </p>
                        <p class="MsoNormal">
                            2. Identification of the copyright work claimed to have been infringed, or, if multiple
                            copyrighted works at a single online site are covered by a single notification,
                            a representative list of such works at that site;
                        </p>
                        <p class="MsoNormal">
                            3. Identification of the material that is claimed to be infringing or to be the
                            subject of infringing activity and that is to be removed or access to which is to
                            be disabled, and information reasonably sufficient to permit us to locate the material;
                        </p>
                        <p class="MsoNormal">
                            4. Information reasonably sufficient to permit us to contact the complaining party;
                        </p>
                        <p class="MsoNormal">
                            5. A statement that the complaining party has a good-faith belief that use of the
                            material in the manner complained of is not authorized by the copyright owner, its
                            agent, or the law; and
                        </p>
                        <p class="MsoNormal">
                            6. A statement that the information in the notification is accurate, and under penalty
                            of perjury, that the complaining party is authorized to act on behalf of the owner
                            of an exclusive right that is allegedly infringed.
                        </p>
                        <p class="MsoNormal">
                            For copyright inquiries under the Digital Millennium Copyright Act please contact:
                        </p>
                        <p class="MsoNormal">
                            &nbsp;
                        </p>
                        <p class="MsoNormal">
                            &nbsp;
                        </p>
                        <p class="MsoNormal">
                            Copyright Agent
                        </p>
                        <p class="MsoNormal">
                            newcam18
                        </p>
                        <p class="MsoNormal">
                            Phone:359882929104
                        </p>
                        <p class="MsoNormal">
                            Fax:359882929104
                        </p>
                        <p class="MsoNormal">
                            &nbsp;
                        </p>
                        <p class="MsoNormal">
                            For web posting, reprint, transcript or licensing requests for newcam18 material,
                            please contact support@newcam.biz
                        </p>
                        <p class="MsoNormal">
                            &nbsp;
                        </p>
                        <p class="MsoNormal">
                            For any questions or requests other than copyright issues or licensing requests,
                            please contact support@newcam.biz
                        </p>
                        <p class="MsoNormal">
                            &nbsp;
                        </p>
                        <p class="MsoNormal">
                            14. Supplemental Terms.
                        </p>
                        <p class="MsoNormal">
                            (A) Billing and Payments
                        </p>
                        <p class="MsoNormal">
                            newcam18 has no basic fee for membership to the free areas of the Service. However,
                            some areas on the Site such as the video chats with the hosts and viewing the host’s
                            videos will incur charges to you at the rate set by newcam.biz. The prices for the
                            video chats are based on per-minute rates and are disclosed to you prior to your
                            credit card being charged and your entrance into the video chat room. It is agreed
                            that each time you enter and use the newcam.biz Service; you agree that newcam.biz
                            is authorized to charge (and recharge) your Credit Card that you previously provided
                            to newcam18. Subscriber is responsible for all charges associated with connecting
                            to newcam18.
                        </p>
                        <p class="MsoNormal">
                            You may review a copy of all of your records of usage of the newcam18 Service
                            as well as the status of any applicable credits in the customer service section.
                            For all billing inquiries, please contact Customer Support at support@newcam.biz
                        </p>
                        <p class="MsoNormal">
                            Important: In case newcam18 does not receive the full amount of your owed newcam.biz
                            charges under your account, you will be liable for all attorney and collection fees
                            regarding efforts to collect any unpaid payments owed by you. In cases of termination
                            and/or cancellation of your account you will remain liable for all payments of your
                            account as well as other such liabilities.
                        </p>
                        <p class="MsoNormal">
                            newcam18 has the right, at its own and sole discretion and at all time, to change
                            the billing and payments methods and to add or remove other methods regarding the
                            billing and payments issues. NEWCAM18 reserves the right, at its own and sole
                            discretion and at all time, to change all and any fees and charges regarding the
                            Service. In case you do not wish to remain a member due to a change in the Terms
                            and Conditions, you may terminate your membership as provided in the customer service
                            section. Please note that your continued use of the Site following the changes of
                            the Terms and Conditions constitutes acceptance of all such changes.
                        </p>
                        <p class="MsoNormal">
                            Please note that in any case of a charge back occurring from your credit card to
                            one or more charges of newcam.biz, your account will be terminated immediately and
                            all of your credits in the NEWCAM18 system will be forfeited.
                        </p>
                        <p class="MsoNormal">
                            15. Refund policy .
                        </p>
                        <p class="MsoNormal">
                            As long as you have not used in general and purchased through credit card you can
                            get your money back after 30 days. If you use small or large part of the time ,you
                            wont be able to ask for refund
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
