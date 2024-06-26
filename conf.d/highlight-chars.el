(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require 'highlight-chars)
  ;; in highlight-chars-autoloads.el
  (set-face-background 'hc-tab "DarkGreen")
  (add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
  (add-hook 'font-lock-mode-hook 'hc-highlight-hard-spaces) ; \u00a0 &nbsp
  (add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace)

  ;; https://www.compart.com/en/unicode/category
  ;; console.log([
  ;;   // header
  ;;   document.title.replace("List of Unicode Characters of Category “", ";; ").replace("”", ""),
  ;;   `;; ${location.href}`,
  ;;   // make list
  ;;   [...document.querySelectorAll('.list-grid a')]
  ;;   .map(a=>{
  ;;     return ['.uid', '.text', '.name.hyphenate']
  ;;       .map(sel=>a.querySelector(sel).innerText)
  ;;     })
  ;;   .map(val=>{
  ;;     const code = val[0].replace(/^U\+/, "u")
  ;;     const text = val[1]
  ;;     const name = val[2]
  ;;     return `;; ${name} "${text}"
  ;; "\\${code}"`
  ;;   }).join('\n')
  ;; ].join('\n')
  ;; )

  ;; set my highlight target chars
  (setq my-hc-highlight-chars '(

                                ;; Control
                                ;; https://www.compart.com/en/unicode/category/Cc
                                ;; ;; <Null> (NUL) "NUL"
                                ;; "\u0000" ; (insert "`\u0000`")` `
                                ;; ;; <Start of Heading> (SOH) "SOH"
                                ;; "\u0001" ; (insert "`\u0001`")``
                                ;; ;; <Start of Text> (STX) "STX"
                                ;; "\u0002" ; (insert "`\u0002`")``
                                ;; ;; <End of Text> (ETX) "ETX"
                                ;; "\u0003" ; (insert "`\u0003`")``
                                ;; ;; <End of Transmission> (EOT) "EOT"
                                ;; "\u0004" ; (insert "`\u0004`")``
                                ;; ;; <Enquiry> (ENQ) "ENQ"
                                ;; "\u0005" ; (insert "`\u0005`")``
                                ;; ;; <Acknowledge> (ACK) "ACK"
                                ;; "\u0006" ; (insert "`\u0006`")``
                                ;; ;; <Alert> (BEL) "BEL"
                                ;; "\u0007" ; (insert "`\u0007`")``
                                ;; ;; <Backspace> (BS) "BS"
                                ;; "\u0008" ; (insert "`\u0008`")``
                                ;; Exclude (covered by hc-highlight-tabs)
                                ;; <Character Tabulation> (HT, TAB) "HT"
                                ;; "\u0009" ; (insert "`\u0009`")`	`
                                ;; Excludes
                                ;; <End of Line> (EOL, LF, NL) "LF"
                                ;; "\u000A" ; (insert "`\u000A`")``
                                ;; ;; <Line Tabulation> (VT) "VT"
                                ;; "\u000B" ; (insert "`\u000B`")``
                                ;; ;; <Form Feed> (FF) "FF"
                                ;; "\u000C" ; (insert "`\u000C`")``
                                ;; Excludes
                                ;; <Carriage Return> (CR) "CR"
                                ;; "\u000D" ; (insert "`\u000D`")``
                                ;; ;; <Locking-Shift One> (SO) "SO"
                                ;; "\u000E" ; (insert "`\u000E`")``
                                ;; <Locking-Shift Zero> (SI) "SI"
                                "\u000F" ; (insert "`\u000F`")``
                                ;; ;; <Data Link Escape> (DLE) "DLE"
                                ;; "\u0010" ; (insert "`\u0010`")``
                                ;; ;; <Device Control One> (DC1) "DC1"
                                ;; "\u0011" ; (insert "`\u0011`")``
                                ;; ;; <Device Control Two> (DC2) "DC2"
                                ;; "\u0012" ; (insert "`\u0012`")``
                                ;; ;; <Device Control Three> (DC3) "DC3"
                                ;; "\u0013" ; (insert "`\u0013`")``
                                ;; ;; <Device Control Four> (DC4) "DC4"
                                ;; "\u0014" ; (insert "`\u0014`")``
                                ;; ;; <Negative Acknowledge> (NAK) "NAK"
                                ;; "\u0015" ; (insert "`\u0015`")``
                                ;; ;; <Synchronous Idle> (SYN) "SYN"
                                ;; "\u0016" ; (insert "`\u0016`")``
                                ;; ;; <End of Transmission Block> (ETB) "ETB"
                                ;; "\u0017" ; (insert "`\u0017`")``
                                ;; ;; <Cancel> (CAN) "CAN"
                                ;; "\u0018" ; (insert "`\u0018`")``
                                ;; ;; <End of Medium> (EOM) "EOM"
                                ;; "\u0019" ; (insert "`\u0019`")``
                                ;; ;; <Substitute> (SUB) "SUB"
                                ;; "\u001A" ; (insert "`\u001A`")``
                                ;; ;; <Escape> (ESC) "ESC"
                                ;; "\u001B" ; (insert "`\u001B`")``
                                ;; ;; <File Separator> (FS) "FS"
                                ;; "\u001C" ; (insert "`\u001C`")``
                                ;; ;; <Group Separator> (GS) "GS"
                                ;; "\u001D" ; (insert "`\u001D`")``
                                ;; ;; <Information Separator Two> (RS) "RS"
                                ;; "\u001E" ; (insert "`\u001E`")``
                                ;; ;; <Information Separator One> (US) "US"
                                ;; "\u001F" ; (insert "`\u001F`")``
                                ;; ;; <Delete> (DEL) "DEL"
                                ;; "\u007F" ; (insert "`\u007F`")``
                                ;; ;; <Padding Character> (PAD) "PAD"
                                ;; "\u0080" ; (insert "`\u0080`")``
                                ;; ;; <High Octet Preset> (HOP) "HOP"
                                ;; "\u0081" ; (insert "`\u0081`")``
                                ;; ;; <Break Permitted Here> (BPH) "BPH"
                                ;; "\u0082" ; (insert "`\u0082`")``
                                ;; ;; <No Break Here> (NBH) "NBH"
                                ;; "\u0083" ; (insert "`\u0083`")``
                                ;; ;; <Index> (IND) "IND"
                                ;; "\u0084" ; (insert "`\u0084`")``
                                ;; ;; <Next Line> (NEL) "NEL"
                                ;; "\u0085" ; (insert "`\u0085`")``
                                ;; ;; <Start of Selected Area> (SSA) "SSA"
                                ;; "\u0086" ; (insert "`\u0086`")``
                                ;; ;; <End of Selected Area> (ESA) "ESA"
                                ;; "\u0087" ; (insert "`\u0087`")``
                                ;; ;; <Character Tabulation Set> (HTS) "HTS"
                                ;; "\u0088" ; (insert "`\u0088`")``
                                ;; ;; <Character Tabulation with Justification> (HTJ) "HTJ"
                                ;; "\u0089" ; (insert "`\u0089`")``
                                ;; ;; <Line Tabulation Set> (VTS) "VTS"
                                ;; "\u008A" ; (insert "`\u008A`")``
                                ;; ;; <Partial Line Down> (PLD) "PLD"
                                ;; "\u008B" ; (insert "`\u008B`")``
                                ;; ;; <Partial Line Backward> (PLU) "PLU"
                                ;; "\u008C" ; (insert "`\u008C`")``
                                ;; ;; <Reverse Index> (RI) "RI"
                                ;; "\u008D" ; (insert "`\u008D`")``
                                ;; ;; <Single Shift Two> (SS2) "SS2"
                                ;; "\u008E" ; (insert "`\u008E`")``
                                ;; ;; <Single Shift Three> (SS3) "SS3"
                                ;; "\u008F" ; (insert "`\u008F`")``
                                ;; ;; <Device Control String> (DCS) "DCS"
                                ;; "\u0090" ; (insert "`\u0090`")``
                                ;; ;; <Private Use One> (PU1) "PU1"
                                ;; "\u0091" ; (insert "`\u0091`")``
                                ;; ;; <Private Use Two> (PU2) "PU2"
                                ;; "\u0092" ; (insert "`\u0092`")``
                                ;; ;; <Set Transmit State> (STS) "STS"
                                ;; "\u0093" ; (insert "`\u0093`")``
                                ;; ;; <Cancel Character> (CCH) "CCH"
                                ;; "\u0094" ; (insert "`\u0094`")``
                                ;; ;; <Message Waiting> (MW) "MW"
                                ;; "\u0095" ; (insert "`\u0095`")``
                                ;; ;; <Start of Guarded Area> (SPA) "SPA"
                                ;; "\u0096" ; (insert "`\u0096`")``
                                ;; ;; <End of Guarded Area> (EPA) "EPA"
                                ;; "\u0097" ; (insert "`\u0097`")``
                                ;; ;; <Start of String> (SOS) "SOS"
                                ;; "\u0098" ; (insert "`\u0098`")``
                                ;; ;; <Single Graphic Character Introducer> (SGC) "SGC"
                                ;; "\u0099" ; (insert "`\u0099`")``
                                ;; ;; <Single Character Introducer> (SCI) "SCI"
                                ;; "\u009A" ; (insert "`\u009A`")``
                                ;; ;; <Control Sequence Introducer> (CSI) "CSI"
                                ;; "\u009B" ; (insert "`\u009B`")``
                                ;; ;; <String Terminator> (ST) "ST"
                                ;; "\u009C" ; (insert "`\u009C`")``
                                ;; ;; <Operating System Command> (OSC) "OSC"
                                ;; "\u009D" ; (insert "`\u009D`")``
                                ;; ;; <Privacy Message> (PM) "PM"
                                ;; "\u009E" ; (insert "`\u009E`")``
                                ;; ;; <Application Program Command> (APC) "APC"
                                ;; "\u009F" ; (insert "`\u009F`")``

                                ;; Format
                                ;; https://www.compart.com/en/unicode/category/Cf
                                ;; ;; Soft Hyphen (SHY) "SHY"
                                ;; "\u00AD" ; (insert "`\u00AD`")`­`
                                ;; ;; Arabic Number Sign ""
                                ;; "\u0600" ; (insert "`\u0600`")`؀`
                                ;; ;; Arabic Sign Sanah ""
                                ;; "\u0601" ; (insert "`\u0601`")`؁`
                                ;; ;; Arabic Footnote Marker ""
                                ;; "\u0602" ; (insert "`\u0602`")`؂`
                                ;; ;; Arabic Sign Safha ""
                                ;; "\u0603" ; (insert "`\u0603`")`؃`
                                ;; ;; Arabic Sign Samvat ""
                                ;; "\u0604" ; (insert "`\u0604`")`؄`
                                ;; ;; Arabic Number Mark Above ""
                                ;; "\u0605" ; (insert "`\u0605`")`؅`
                                ;; ;; Arabic Letter Mark (ALM) "ALM"
                                ;; "\u061C" ; (insert "`\u061C`")`؜`
                                ;; ;; Arabic End of Ayah ""
                                ;; "\u06DD" ; (insert "`\u06DD`")`۝`
                                ;; ;; Syriac Abbreviation Mark ""
                                ;; "\u070F" ; (insert "`\u070F`")`܏`
                                ;; ;; Arabic Disputed End of Ayah ""
                                ;; "\u08E2" ; (insert "`\u08E2`")`࣢`
                                ;; ;; Mongolian Vowel Separator (MVS) "MVS"
                                ;; "\u180E" ; (insert "`\u180E`")`᠎`
                                ;; Zero Width Space (ZWSP) "ZWSP"
                                ;; zero width spaces "​"
                                "\u200B" ; (insert "`\u200B`")`​`
                                ;; Zero Width Non-Joiner (ZWNJ) "ZWNJ"
                                "\u200C" ; (insert "`\u200C`")`‌`
                                ;; Zero Width Joiner (ZWJ) "ZWJ"
                                "\u200D" ; (insert "`\u200D`")`‍`
                                ;; Left-to-Right Mark (LRM) "LRM"
                                "\u200E" ; (insert "`\u200E`")`‎`
                                ;; Right-to-Left Mark (RLM) "RLM"
                                "\u200F" ; (insert "`\u200F`")`‏`
                                ;; Left-to-Right Embedding (LRE) "LRE"
                                "\u202A" ; (insert "`\u202A`")`‪`
                                ;; Right-to-Left Embedding (RLE) "RLE"
                                "\u202B" ; (insert "`\u202B`")`‫`
                                ;; Pop Directional Formatting (PDF) "PDF"
                                "\u202C" ; (insert "`\u202C`")`‬`
                                ;; Left-to-Right Override (LRO) "LRO"
                                "\u202D" ; (insert "`\u202D`")`‭`
                                ;; Right-to-Left Override (RLO) "RLO"
                                "\u202E" ; (insert "`\u202E`")`‮`
                                ;; Word Joiner (WJ) "WJ"
                                "\u2060" ; (insert "`\u2060`")`⁠`
                                ;; Function Application ""
                                "\u2061" ; (insert "`\u2061`")`⁡`
                                ;; Invisible Times ""
                                "\u2062" ; (insert "`\u2062`")`⁢`
                                ;; Invisible Separator ""
                                "\u2063" ; (insert "`\u2063`")`⁣`
                                ;; Invisible Plus ""
                                "\u2064" ; (insert "`\u2064`")`⁤`
                                ;; Left-to-Right Isolate (LRI) "LRI"
                                "\u2066" ; (insert "`\u2066`")`⁦`
                                ;; Right-to-Left Isolate (RLI) "RLI"
                                "\u2067" ; (insert "`\u2067`")`⁧`
                                ;; First Strong Isolate (FSI) "FSI"
                                "\u2068" ; (insert "`\u2068`")`⁨`
                                ;; Pop Directional Isolate (PDI) "PDI"
                                "\u2069" ; (insert "`\u2069`")`⁩`
                                ;; Inhibit Symmetric Swapping ""
                                "\u206A" ; (insert "`\u206A`")`⁪`
                                ;; Activate Symmetric Swapping ""
                                "\u206B" ; (insert "`\u206B`")`⁫`
                                ;; Inhibit Arabic Form Shaping ""
                                "\u206C" ; (insert "`\u206C`")`⁬`
                                ;; Activate Arabic Form Shaping ""
                                "\u206D" ; (insert "`\u206D`")`⁭`
                                ;; National Digit Shapes ""
                                "\u206E" ; (insert "`\u206E`")`⁮`
                                ;; Nominal Digit Shapes ""
                                "\u206F" ; (insert "`\u206F`")`⁯`
                                ;; Zero Width No-Break Space (BOM, ZWNBSP) "BOM"
                                "\uFEFF" ; (insert "`\uFEFF`")`﻿`
                                ;; Interlinear Annotation Anchor ""
                                "\uFFF9" ; (insert "`\uFFF9`")`￹`
                                ;; Interlinear Annotation Separator ""
                                "\uFFFA" ; (insert "`\uFFFA`")`￺`
                                ;; Interlinear Annotation Terminator ""
                                "\uFFFB" ; (insert "`\uFFFB`")`￻`
                                ;; ;; Kaithi Number Sign ""
                                ;; "\u110BD" ; (insert "`\u110BD`")`ᄋD`
                                ;; ;; Kaithi Number Sign Above ""
                                ;; "\u110CD" ; (insert "`\u110CD`")`ᄌD`
                                ;; ;; Egyptian Hieroglyph Vertical Joiner ""
                                ;; "\u13430" ; (insert "`\u13430`")`ፃ0`
                                ;; ;; Egyptian Hieroglyph Horizontal Joiner ""
                                ;; "\u13431" ; (insert "`\u13431`")`ፃ1`
                                ;; ;; Egyptian Hieroglyph Insert at Top Start ""
                                ;; "\u13432" ; (insert "`\u13432`")`ፃ2`
                                ;; ;; Egyptian Hieroglyph Insert at Bottom Start ""
                                ;; "\u13433" ; (insert "`\u13433`")`ፃ3`
                                ;; ;; Egyptian Hieroglyph Insert at Top End ""
                                ;; "\u13434" ; (insert "`\u13434`")`ፃ4`
                                ;; ;; Egyptian Hieroglyph Insert at Bottom End ""
                                ;; "\u13435" ; (insert "`\u13435`")`ፃ5`
                                ;; ;; Egyptian Hieroglyph Overlay Middle ""
                                ;; "\u13436" ; (insert "`\u13436`")`ፃ6`
                                ;; ;; Egyptian Hieroglyph Begin Segment ""
                                ;; "\u13437" ; (insert "`\u13437`")`ፃ7`
                                ;; ;; Egyptian Hieroglyph End Segment ""
                                ;; "\u13438" ; (insert "`\u13438`")`ፃ8`
                                ;; ;; Shorthand Format Letter Overlap ""
                                ;; "\u1BCA0" ; (insert "`\u1BCA0`")`ᯊ0`
                                ;; ;; Shorthand Format Continuing Overlap ""
                                ;; "\u1BCA1" ; (insert "`\u1BCA1`")`ᯊ1`
                                ;; ;; Shorthand Format Down Step ""
                                ;; "\u1BCA2" ; (insert "`\u1BCA2`")`ᯊ2`
                                ;; ;; Shorthand Format Up Step ""
                                ;; "\u1BCA3" ; (insert "`\u1BCA3`")`ᯊ3`
                                ;; ;; Musical Symbol Begin Beam ""
                                ;; "\u1D173" ; (insert "`\u1D173`")`ᴗ3`
                                ;; ;; Musical Symbol End Beam ""
                                ;; "\u1D174" ; (insert "`\u1D174`")`ᴗ4`
                                ;; ;; Musical Symbol Begin Tie ""
                                ;; "\u1D175" ; (insert "`\u1D175`")`ᴗ5`
                                ;; ;; Musical Symbol End Tie ""
                                ;; "\u1D176" ; (insert "`\u1D176`")`ᴗ6`
                                ;; ;; Musical Symbol Begin Slur ""
                                ;; "\u1D177" ; (insert "`\u1D177`")`ᴗ7`
                                ;; ;; Musical Symbol End Slur ""
                                ;; "\u1D178" ; (insert "`\u1D178`")`ᴗ8`
                                ;; ;; Musical Symbol Begin Phrase ""
                                ;; "\u1D179" ; (insert "`\u1D179`")`ᴗ9`
                                ;; ;; Musical Symbol End Phrase ""
                                ;; "\u1D17A" ; (insert "`\u1D17A`")`ᴗA`
                                ;; ;; Language Tag ""
                                ;; "\uE0001" ; (insert "`\uE0001`")`1`
                                ;; ;; Tag Space ""
                                ;; "\uE0020" ; (insert "`\uE0020`")`0`
                                ;; ;; Tag Exclamation Mark ""
                                ;; "\uE0021" ; (insert "`\uE0021`")`1`
                                ;; ;; Tag Quotation Mark ""
                                ;; "\uE0022" ; (insert "`\uE0022`")`2`
                                ;; ;; Tag Number Sign ""
                                ;; "\uE0023" ; (insert "`\uE0023`")`3`
                                ;; ;; Tag Dollar Sign ""
                                ;; "\uE0024" ; (insert "`\uE0024`")`4`
                                ;; ;; Tag Percent Sign ""
                                ;; "\uE0025" ; (insert "`\uE0025`")`5`
                                ;; ;; Tag Ampersand ""
                                ;; "\uE0026" ; (insert "`\uE0026`")`6`
                                ;; ;; Tag Apostrophe ""
                                ;; "\uE0027" ; (insert "`\uE0027`")`7`
                                ;; ;; Tag Left Parenthesis ""
                                ;; "\uE0028" ; (insert "`\uE0028`")`8`
                                ;; ;; Tag Right Parenthesis ""
                                ;; "\uE0029" ; (insert "`\uE0029`")`9`
                                ;; ;; Tag Asterisk ""
                                ;; "\uE002A" ; (insert "`\uE002A`")`A`
                                ;; ;; Tag Plus Sign ""
                                ;; "\uE002B" ; (insert "`\uE002B`")`B`
                                ;; ;; Tag Comma ""
                                ;; "\uE002C" ; (insert "`\uE002C`")`C`
                                ;; ;; Tag Hyphen-Minus ""
                                ;; "\uE002D" ; (insert "`\uE002D`")`D`
                                ;; ;; Tag Full Stop ""
                                ;; "\uE002E" ; (insert "`\uE002E`")`E`
                                ;; ;; Tag Solidus ""
                                ;; "\uE002F" ; (insert "`\uE002F`")`F`
                                ;; ;; Tag Digit Zero ""
                                ;; "\uE0030" ; (insert "`\uE0030`")`0`
                                ;; ;; Tag Digit One ""
                                ;; "\uE0031" ; (insert "`\uE0031`")`1`
                                ;; ;; Tag Digit Two ""
                                ;; "\uE0032" ; (insert "`\uE0032`")`2`
                                ;; ;; Tag Digit Three ""
                                ;; "\uE0033" ; (insert "`\uE0033`")`3`
                                ;; ;; Tag Digit Four ""
                                ;; "\uE0034" ; (insert "`\uE0034`")`4`
                                ;; ;; Tag Digit Five ""
                                ;; "\uE0035" ; (insert "`\uE0035`")`5`
                                ;; ;; Tag Digit Six ""
                                ;; "\uE0036" ; (insert "`\uE0036`")`6`
                                ;; ;; Tag Digit Seven ""
                                ;; "\uE0037" ; (insert "`\uE0037`")`7`
                                ;; ;; Tag Digit Eight ""
                                ;; "\uE0038" ; (insert "`\uE0038`")`8`
                                ;; ;; Tag Digit Nine ""
                                ;; "\uE0039" ; (insert "`\uE0039`")`9`
                                ;; ;; Tag Colon ""
                                ;; "\uE003A" ; (insert "`\uE003A`")`A`
                                ;; ;; Tag Semicolon ""
                                ;; "\uE003B" ; (insert "`\uE003B`")`B`
                                ;; ;; Tag Less-Than Sign ""
                                ;; "\uE003C" ; (insert "`\uE003C`")`C`
                                ;; ;; Tag Equals Sign ""
                                ;; "\uE003D" ; (insert "`\uE003D`")`D`
                                ;; ;; Tag Greater-Than Sign ""
                                ;; "\uE003E" ; (insert "`\uE003E`")`E`
                                ;; ;; Tag Question Mark ""
                                ;; "\uE003F" ; (insert "`\uE003F`")`F`
                                ;; ;; Tag Commercial At ""
                                ;; "\uE0040" ; (insert "`\uE0040`")`0`
                                ;; ;; Tag Latin Capital Letter A ""
                                ;; "\uE0041" ; (insert "`\uE0041`")`1`
                                ;; ;; Tag Latin Capital Letter B ""
                                ;; "\uE0042" ; (insert "`\uE0042`")`2`
                                ;; ;; Tag Latin Capital Letter C ""
                                ;; "\uE0043" ; (insert "`\uE0043`")`3`
                                ;; ;; Tag Latin Capital Letter D ""
                                ;; "\uE0044" ; (insert "`\uE0044`")`4`
                                ;; ;; Tag Latin Capital Letter E ""
                                ;; "\uE0045" ; (insert "`\uE0045`")`5`
                                ;; ;; Tag Latin Capital Letter F ""
                                ;; "\uE0046" ; (insert "`\uE0046`")`6`
                                ;; ;; Tag Latin Capital Letter G ""
                                ;; "\uE0047" ; (insert "`\uE0047`")`7`
                                ;; ;; Tag Latin Capital Letter H ""
                                ;; "\uE0048" ; (insert "`\uE0048`")`8`
                                ;; ;; Tag Latin Capital Letter I ""
                                ;; "\uE0049" ; (insert "`\uE0049`")`9`
                                ;; ;; Tag Latin Capital Letter J ""
                                ;; "\uE004A" ; (insert "`\uE004A`")`A`
                                ;; ;; Tag Latin Capital Letter K ""
                                ;; "\uE004B" ; (insert "`\uE004B`")`B`
                                ;; ;; Tag Latin Capital Letter L ""
                                ;; "\uE004C" ; (insert "`\uE004C`")`C`
                                ;; ;; Tag Latin Capital Letter M ""
                                ;; "\uE004D" ; (insert "`\uE004D`")`D`
                                ;; ;; Tag Latin Capital Letter N ""
                                ;; "\uE004E" ; (insert "`\uE004E`")`E`
                                ;; ;; Tag Latin Capital Letter O ""
                                ;; "\uE004F" ; (insert "`\uE004F`")`F`
                                ;; ;; Tag Latin Capital Letter P ""
                                ;; "\uE0050" ; (insert "`\uE0050`")`0`
                                ;; ;; Tag Latin Capital Letter Q ""
                                ;; "\uE0051" ; (insert "`\uE0051`")`1`
                                ;; ;; Tag Latin Capital Letter R ""
                                ;; "\uE0052" ; (insert "`\uE0052`")`2`
                                ;; ;; Tag Latin Capital Letter S ""
                                ;; "\uE0053" ; (insert "`\uE0053`")`3`
                                ;; ;; Tag Latin Capital Letter T ""
                                ;; "\uE0054" ; (insert "`\uE0054`")`4`
                                ;; ;; Tag Latin Capital Letter U ""
                                ;; "\uE0055" ; (insert "`\uE0055`")`5`
                                ;; ;; Tag Latin Capital Letter V ""
                                ;; "\uE0056" ; (insert "`\uE0056`")`6`
                                ;; ;; Tag Latin Capital Letter W ""
                                ;; "\uE0057" ; (insert "`\uE0057`")`7`
                                ;; ;; Tag Latin Capital Letter X ""
                                ;; "\uE0058" ; (insert "`\uE0058`")`8`
                                ;; ;; Tag Latin Capital Letter Y ""
                                ;; "\uE0059" ; (insert "`\uE0059`")`9`
                                ;; ;; Tag Latin Capital Letter Z ""
                                ;; "\uE005A" ; (insert "`\uE005A`")`A`
                                ;; ;; Tag Left Square Bracket ""
                                ;; "\uE005B" ; (insert "`\uE005B`")`B`
                                ;; ;; Tag Reverse Solidus ""
                                ;; "\uE005C" ; (insert "`\uE005C`")`C`
                                ;; ;; Tag Right Square Bracket ""
                                ;; "\uE005D" ; (insert "`\uE005D`")`D`
                                ;; ;; Tag Circumflex Accent ""
                                ;; "\uE005E" ; (insert "`\uE005E`")`E`
                                ;; ;; Tag Low Line ""
                                ;; "\uE005F" ; (insert "`\uE005F`")`F`
                                ;; ;; Tag Grave Accent ""
                                ;; "\uE0060" ; (insert "`\uE0060`")`0`
                                ;; ;; Tag Latin Small Letter A ""
                                ;; "\uE0061" ; (insert "`\uE0061`")`1`
                                ;; ;; Tag Latin Small Letter B ""
                                ;; "\uE0062" ; (insert "`\uE0062`")`2`
                                ;; ;; Tag Latin Small Letter C ""
                                ;; "\uE0063" ; (insert "`\uE0063`")`3`
                                ;; ;; Tag Latin Small Letter D ""
                                ;; "\uE0064" ; (insert "`\uE0064`")`4`
                                ;; ;; Tag Latin Small Letter E ""
                                ;; "\uE0065" ; (insert "`\uE0065`")`5`
                                ;; ;; Tag Latin Small Letter F ""
                                ;; "\uE0066" ; (insert "`\uE0066`")`6`
                                ;; ;; Tag Latin Small Letter G ""
                                ;; "\uE0067" ; (insert "`\uE0067`")`7`
                                ;; ;; Tag Latin Small Letter H ""
                                ;; "\uE0068" ; (insert "`\uE0068`")`8`
                                ;; ;; Tag Latin Small Letter I ""
                                ;; "\uE0069" ; (insert "`\uE0069`")`9`
                                ;; ;; Tag Latin Small Letter J ""
                                ;; "\uE006A" ; (insert "`\uE006A`")`A`
                                ;; ;; Tag Latin Small Letter K ""
                                ;; "\uE006B" ; (insert "`\uE006B`")`B`
                                ;; ;; Tag Latin Small Letter L ""
                                ;; "\uE006C" ; (insert "`\uE006C`")`C`
                                ;; ;; Tag Latin Small Letter M ""
                                ;; "\uE006D" ; (insert "`\uE006D`")`D`
                                ;; ;; Tag Latin Small Letter N ""
                                ;; "\uE006E" ; (insert "`\uE006E`")`E`
                                ;; ;; Tag Latin Small Letter O ""
                                ;; "\uE006F" ; (insert "`\uE006F`")`F`
                                ;; ;; Tag Latin Small Letter P ""
                                ;; "\uE0070" ; (insert "`\uE0070`")`0`
                                ;; ;; Tag Latin Small Letter Q ""
                                ;; "\uE0071" ; (insert "`\uE0071`")`1`
                                ;; ;; Tag Latin Small Letter R ""
                                ;; "\uE0072" ; (insert "`\uE0072`")`2`
                                ;; ;; Tag Latin Small Letter S ""
                                ;; "\uE0073" ; (insert "`\uE0073`")`3`
                                ;; ;; Tag Latin Small Letter T ""
                                ;; "\uE0074" ; (insert "`\uE0074`")`4`
                                ;; ;; Tag Latin Small Letter U ""
                                ;; "\uE0075" ; (insert "`\uE0075`")`5`
                                ;; ;; Tag Latin Small Letter V ""
                                ;; "\uE0076" ; (insert "`\uE0076`")`6`
                                ;; ;; Tag Latin Small Letter W ""
                                ;; "\uE0077" ; (insert "`\uE0077`")`7`
                                ;; ;; Tag Latin Small Letter X ""
                                ;; "\uE0078" ; (insert "`\uE0078`")`8`
                                ;; ;; Tag Latin Small Letter Y ""
                                ;; "\uE0079" ; (insert "`\uE0079`")`9`
                                ;; ;; Tag Latin Small Letter Z ""
                                ;; "\uE007A" ; (insert "`\uE007A`")`A`
                                ;; ;; Tag Left Curly Bracket ""
                                ;; "\uE007B" ; (insert "`\uE007B`")`B`
                                ;; ;; Tag Vertical Line ""
                                ;; "\uE007C" ; (insert "`\uE007C`")`C`
                                ;; ;; Tag Right Curly Bracket ""
                                ;; "\uE007D" ; (insert "`\uE007D`")`D`
                                ;; ;; Tag Tilde ""
                                ;; "\uE007E" ; (insert "`\uE007E`")`E`
                                ;; ;; Cancel Tag ""
                                ;; "\uE007F" ; (insert "`\uE007F`")`F`

                                ;; Line Separator
                                ;; https://www.compart.com/en/unicode/category/Zl
                                ;; Line Separator " "
                                "\u2028" ; (insert "`\u2028`")` `

                                ;; Paragraph Separator
                                ;; https://www.compart.com/en/unicode/category/Zp
                                ;; Paragraph Separator " "
                                "\u2029" ; (insert "`\u2029`")` `

                                ;; Space Separator
                                ;; https://www.compart.com/en/unicode/category/Zs
                                ;; Exclude the space
                                ;; Space (SP) "SP"
                                ;; "\u0020" ; (insert "`\u0020`")` `
                                ;; No-Break Space (NBSP) "NBSP"
                                ;; &nbsp; spaces (hard space) " "
                                ;; Exclude (covered by hc-highlight-hard-spaces)
                                ;; ;; (U+00A0 : char code 160)
                                ;; "\u00A0" ; (insert "`\u00A0`")` `
                                ;; Exclude (not invisible)
                                ;; Ogham Space Mark " "
                                ;; "\u1680" ; (insert "`\u1680`")` `
                                ;; En Quad " "
                                "\u2000" ; (insert "`\u2000`")` `
                                ;; Em Quad " "
                                "\u2001" ; (insert "`\u2001`")` `
                                ;; En Space " "
                                "\u2002" ; (insert "`\u2002`")` `
                                ;; Em Space " "
                                "\u2003" ; (insert "`\u2003`")` `
                                ;; Three-Per-Em Space " "
                                "\u2004" ; (insert "`\u2004`")` `
                                ;; Four-Per-Em Space " "
                                "\u2005" ; (insert "`\u2005`")` `
                                ;; Six-Per-Em Space " "
                                "\u2006" ; (insert "`\u2006`")` `
                                ;; Figure Space " "
                                "\u2007" ; (insert "`\u2007`")` `
                                ;; Punctuation Space " "
                                "\u2008" ; (insert "`\u2008`")` `
                                ;; Thin Space " "
                                "\u2009" ; (insert "`\u2009`")` `
                                ;; Hair Space " "
                                "\u200A" ; (insert "`\u200A`")` `
                                ;; ;; Narrow No-Break Space (NNBSP) "NNBSP"
                                ;; "\u202F" ; (insert "`\u202F`")` `
                                ;; ;; Medium Mathematical Space (MMSP) "MMSP"
                                ;; "\u205F" ; (insert "`\u205F`")` `
                                ;; Ideographic Space "　"
                                ;; wide space
                                "\u3000" ; (insert "`\u3000`")`　`
                                ))
  ;; set face if you want to change
  (defface my-hc-highlight-face '((t (:background "PaleGreen")))
    "*Face for highlighting chars in `my-hc-highlight-chars' in Font-Lock mode."
    :group 'Highlight-Characters :group 'faces)

  ;; enable highlight
  (hc-highlight-chars my-hc-highlight-chars 'my-hc-highlight-face nil t)
  ;; (hc-highlight-chars my-hc-highlight-chars 'my-hc-highlight-face t t)

  ;; Default : HotPink
  ;; (hc-highlight-chars my-hc-highlight-chars 'hc-other-char nil t)
  ;; (hc-highlight-chars my-hc-highlight-chars 'hc-other-char t t)
  )
