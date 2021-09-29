<?xml version="1.0" encoding="utf-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
   <title>Schematron 1.5 rules</title>
   <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
   <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
   <ns prefix="rng" uri="http://relaxng.org/ns/structure/1.0"/>
   <ns prefix="s" uri="http://www.ascc.net/xml/schematron"/>
   <ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>
   <ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>
   <ns prefix="teix" uri="http://www.tei-c.org/ns/Examples"/>
   <pattern id="tei_all-att.datable.w3c-constraint-att-datable-w3c-when-1">
      <rule context="tei:*[@when]">
        <report test="@notBefore|@notAfter|@from|@to" role="nonfatal">The @when attribute cannot be used with any other att.datable.w3c attributes.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-att.datable.w3c-constraint-att-datable-w3c-from-2">
      <rule context="tei:*[@from]">
        <report test="@notBefore" role="nonfatal">The @from and @notBefore attributes cannot be used together.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-att.datable.w3c-constraint-att-datable-w3c-to-3">
      <rule context="tei:*[@to]">
        <report test="@notAfter" role="nonfatal">The @to and @notAfter attributes cannot be used together.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-att.datable-calendar-constraint-calendar-4">
      <rule context="tei:*[@calendar]">
            <assert test="string-length(.) gt 0"> @calendar indicates one or more systems or calendars to
              which the date represented by the content of this element belongs, but this
              <name/> element has no textual content.</assert>
          </rule>
   </pattern>
   <pattern id="tei_all-att.measurement-constraint-att-measurement-unitRef-5">
      <rule context="tei:*[@unitRef]">
        <report test="@unit" role="info">The @unit attribute may be unnecessary when @unitRef is present.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-att.typed-constraint-subtypeTyped-6">
      <rule context="tei:*[@subtype]">
        <assert test="@type">The <name/> element should not be categorized in detail with @subtype unless also categorized in general with @type</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-att.pointing-targetLang-constraint-targetLang-7">
      <rule context="tei:*[not(self::tei:schemaSpec)][@targetLang]">
            <assert test="@target">@targetLang should only be used on <name/> if @target is specified.</assert>
          </rule>
   </pattern>
   <pattern id="tei_all-att.spanning-spanTo-constraint-spanTo-2-8">
      <rule context="tei:*[@spanTo]">
            <assert test="id(substring(@spanTo,2)) and following::*[@xml:id=substring(current()/@spanTo,2)]">
The element indicated by @spanTo (<value-of select="@spanTo"/>) must follow the current element <name/>
                  </assert>
          </rule>
   </pattern>
   <pattern id="tei_all-att.styleDef-schemeVersion-constraint-schemeVersionRequiresScheme-9">
      <rule context="tei:*[@schemeVersion]">
            <assert test="@scheme and not(@scheme = 'free')">
              @schemeVersion can only be used if @scheme is specified.
            </assert>
          </rule>
   </pattern>
   <pattern id="tei_all-p-constraint-abstractModel-structure-p-10">
      <rule context="tei:p">
         <report test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab)          and not(parent::tei:exemplum                |parent::tei:item                |parent::tei:note                |parent::tei:q                |parent::tei:quote                |parent::tei:remarks                |parent::tei:said                |parent::tei:sp                |parent::tei:stage                |parent::tei:cell                |parent::tei:figure                )">
        Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.
      </report>
      </rule>
   </pattern>
   <pattern id="tei_all-p-constraint-abstractModel-structure-l-11">
      <rule context="tei:p">
         <report test="(ancestor::tei:l or ancestor::tei:lg) and not(parent::tei:figure or parent::tei:note or ancestor::tei:floatingText)">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab, unless p is a child of figure or note, or is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="tei_all-desc-constraint-deprecationInfo-only-in-deprecated-12">
      <rule context="tei:desc[ @type eq 'deprecationInfo']">
        <assert test="../@validUntil">Information about a
        deprecation should only be present in a specification element
        that is being deprecated: that is, only an element that has a
        @validUntil attribute should have a child &lt;desc
        type="deprecationInfo"&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-rt-target-constraint-rt-target-not-span-13">
      <rule context="tei:rt">
         <report test="../@from | ../@to">When target= is
            present, neither from= nor to= should be.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-rt-from-constraint-rt-from-14">
      <rule context="tei:rt">
         <assert test="../@to">When from= is present, the to=
            attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-rt-to-constraint-rt-to-15">
      <rule context="tei:rt">
         <assert test="../@from">When to= is present, the from=
            attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-ptr-constraint-ptrAtts-16">
      <rule context="tei:ptr">
         <report test="@target and @cRef">Only one of the
attributes @target and @cRef may be supplied on <name/>.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-ref-constraint-refAtts-17">
      <rule context="tei:ref">
         <report test="@target and @cRef">Only one of the
	attributes @target' and @cRef' may be supplied on <name/>
         </report>
      </rule>
   </pattern>
   <pattern id="tei_all-list-constraint-gloss-list-must-have-labels-18">
      <rule context="tei:list[@type='gloss']">
	        <assert test="tei:label">The content of a "gloss" list should include a sequence of one or more pairs of a label element followed by an item element</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-relatedItem-constraint-targetorcontent1-19">
      <rule context="tei:relatedItem">
         <report test="@target and count( child::* ) &gt; 0">
If the @target attribute on <name/> is used, the
relatedItem element must be empty</report>
         <assert test="@target or child::*">A relatedItem element should have either a 'target' attribute
        or a child element to indicate the related bibliographic item</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-l-constraint-abstractModel-structure-l-20">
      <rule context="tei:l">
         <report test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">
        Abstract model violation: Lines may not contain lines or lg elements.
      </report>
      </rule>
   </pattern>
   <pattern id="tei_all-lg-constraint-atleast1oflggapl-21">
      <rule context="tei:lg">
         <assert test="count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0">An lg element
        must contain at least one child l, lg, or gap element.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-lg-constraint-abstractModel-structure-l-22">
      <rule context="tei:lg">
         <report test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">
        Abstract model violation: Lines may not contain line groups.
      </report>
      </rule>
   </pattern>
   <pattern id="tei_all-quotation-constraint-quotationContents-23">
      <rule context="tei:quotation">
         <report test="not(@marks) and not (tei:p)">
On <name/>, either the @marks attribute should be used, or a paragraph of description provided</report>
      </rule>
   </pattern>
   <pattern id="tei_all-citeStructure-delim-constraint-citestructure-inner-delim-24">
      <rule context="tei:citeStructure[parent::tei:citeStructure]">
            <assert test="@delim">A <name/> with a parent <name/> must have a @delim attribute.</assert>
          </rule>
   </pattern>
   <pattern id="tei_all-citeStructure-match-constraint-citestructure-outer-match-25">
      <rule context="tei:citeStructure[not(parent::tei:citeStructure)]">
            <assert test="starts-with(@match,'/')">An XPath in @match on the outer <name/> must start with '/'.</assert>
          </rule>
   </pattern>
   <pattern id="tei_all-citeStructure-match-constraint-citestructure-inner-match-26">
      <rule context="tei:citeStructure[parent::tei:citeStructure]">
            <assert test="not(starts-with(@match,'/'))">An XPath in @match must not start with '/' except on the outer <name/>.</assert>
          </rule>
   </pattern>
   <pattern id="tei_all-div-constraint-abstractModel-structure-l-29">
      <rule context="tei:div">
         <report test="(ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText)">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="tei_all-div-constraint-abstractModel-structure-p-30">
      <rule context="tei:div">
         <report test="(ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText)">
        Abstract model violation: p and ab may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="tei_all-shift-constraint-shiftNew-31">
      <rule context="tei:shift">
         <assert test="@new" role="warning">              
The @new attribute should always be supplied; use the special value
"normal" to indicate that the feature concerned ceases to be
remarkable at this point.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-s-constraint-noNestedS-32">
      <rule context="tei:s">
         <report test="tei:s">You may not nest one s element within
      another: use seg instead</report>
      </rule>
   </pattern>
   <pattern id="tei_all-span-constraint-targetfrom-33">
      <rule context="tei:span">
         <report test="@from and @target">
Only one of the attributes @target and @from may be supplied on <name/>
         </report>
      </rule>
   </pattern>
   <pattern id="tei_all-span-constraint-targetto-34">
      <rule context="tei:span">
         <report test="@to and @target">
Only one of the attributes @target and @to may be supplied on <name/>
         </report>
      </rule>
   </pattern>
   <pattern id="tei_all-span-constraint-tonotfrom-35">
      <rule context="tei:span">
         <report test="@to and not(@from)">
If @to is supplied on <name/>, @from must be supplied as well</report>
      </rule>
   </pattern>
   <pattern id="tei_all-span-constraint-tofrom-36">
      <rule context="tei:span">
         <report test="contains(normalize-space(@to),' ') or contains(normalize-space(@from),' ')">
The attributes @to and @from on <name/> may each contain only a single value</report>
      </rule>
   </pattern>
   <pattern id="tei_all-catchwords-constraint-catchword_in_msDesc-37">
      <rule context="tei:catchwords">
         <assert test="ancestor::tei:msDesc or ancestor::tei:egXML">The <name/> element should not be used outside of msDesc.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-dimensions-constraint-duplicateDim-38">
      <rule context="tei:dimensions">
         <report test="count(tei:width)&gt; 1">
The element <name/> may appear once only
      </report>
         <report test="count(tei:height)&gt; 1">
The element <name/> may appear once only
      </report>
         <report test="count(tei:depth)&gt; 1">
The element <name/> may appear once only
      </report>
      </rule>
   </pattern>
   <pattern id="tei_all-secFol-constraint-secFol_in_msDesc-39">
      <rule context="tei:secFol">
         <assert test="ancestor::tei:msDesc or ancestor::tei:egXML">The <name/> element should not be used outside of msDesc.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-signatures-constraint-signatures_in_msDesc-40">
      <rule context="tei:signatures">
         <assert test="ancestor::tei:msDesc or ancestor::tei:egXML">The <name/> element should not be used outside of msDesc.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-msIdentifier-constraint-msId_minimal-41">
      <rule context="tei:msIdentifier">
         <report test="not(parent::tei:msPart) and (local-name(*[1])='idno' or local-name(*[1])='altIdentifier' or normalize-space(.)='')">An msIdentifier must contain either a repository or location.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-path-constraint-pathmustnotbeclosed-42">
      <rule context="tei:path[@points]">
        
        <let name="firstPair" value="tokenize( normalize-space( @points ), ' ')[1]"/>
        <let name="lastPair"
              value="tokenize( normalize-space( @points ), ' ')[last()]"/>
        <let name="firstX" value="xs:float( substring-before( $firstPair, ',') )"/>
        <let name="firstY" value="xs:float( substring-after( $firstPair, ',') )"/>
        <let name="lastX" value="xs:float( substring-before( $lastPair, ',') )"/>
        <let name="lastY" value="xs:float( substring-after( $lastPair, ',') )"/>
        <report test="$firstX eq $lastX  and  $firstY eq $lastY">The first and
          last elements of this path are the same. To specify a closed polygon, use
          the zone element rather than the path element. </report>
      </rule>
   </pattern>
   <pattern id="tei_all-addSpan-constraint-spanTo-43">
      <rule context="tei:addSpan">
         <assert test="@spanTo">The @spanTo attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-damageSpan-constraint-spanTo-45">
      <rule context="tei:damageSpan">
         <assert test="@spanTo">
The @spanTo attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-delSpan-constraint-spanTo-47">
      <rule context="tei:delSpan">
         <assert test="@spanTo">The @spanTo attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-subst-constraint-substContents1-49">
      <rule context="tei:subst">
         <assert test="child::tei:add and (child::tei:del or child::tei:surplus)">
            <name/> must have at least one child add and at least one child del or surplus</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-rdgGrp-constraint-only1lem-50">
      <rule context="tei:rdgGrp">
         <assert test="count(tei:lem) &lt; 2">Only one &lt;lem&gt; element may appear within a &lt;rdgGrp&gt;</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-variantEncoding-location-constraint-variantEncodingLocation-51">
      <rule context="tei:variantEncoding">
            <assert test="(@location != 'external') or (@method != 'parallel-segmentation')">
              The @location value "external" is inconsistent with the
              parallel-segmentation method of apparatus markup.</assert>
          </rule>
   </pattern>
   <pattern id="tei_all-relation-constraint-reforkeyorname-52">
      <rule context="tei:relation">
         <assert test="@ref or @key or @name">One of the attributes  'name', 'ref' or 'key' must be supplied</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-relation-constraint-activemutual-53">
      <rule context="tei:relation">
         <report test="@active and @mutual">Only one of the attributes @active and @mutual may be supplied</report>
      </rule>
   </pattern>
   <pattern id="tei_all-relation-constraint-activepassive-54">
      <rule context="tei:relation">
         <report test="@passive and not(@active)">the attribute 'passive' may be supplied only if the attribute 'active' is supplied</report>
      </rule>
   </pattern>
   <pattern id="tei_all-objectIdentifier-constraint-objectIdentifier_minimal-55">
      <rule context="tei:objectIdentifier">
         <report test="not(count(*) gt 0)">An objectIdentifier must contain at minimum a single piece of locating or identifying information.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-link-constraint-linkTargets3-56">
      <rule context="tei:link">
         <assert test="contains(normalize-space(@target),' ')">You must supply at least two values for @target or  on <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="tei_all-ab-constraint-abstractModel-structure-ab-57">
      <rule context="tei:ab">
         <report test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab)          and not(parent::tei:exemplum         |parent::tei:item         |parent::tei:note         |parent::tei:q         |parent::tei:quote         |parent::tei:remarks         |parent::tei:said         |parent::tei:sp         |parent::tei:stage         |parent::tei:cell         |parent::tei:figure)">
        Abstract model violation: ab may not occur inside paragraphs or other ab elements.
      </report>
      </rule>
   </pattern>
   <pattern id="tei_all-ab-constraint-abstractModel-structure-l-58">
      <rule context="tei:ab">
         <report test="(ancestor::tei:l or ancestor::tei:lg) and not(parent::tei:figure or parent::tei:note or ancestor::tei:floatingText)">
        Abstract model violation: Lines may not contain higher-level divisions such as p or ab, unless ab is a child of figure or note, or is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="tei_all-join-constraint-joinTargets3-59">
      <rule context="tei:join">
         <assert test="contains(@target,' ')">
You must supply at least two values for @target on <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="tei_all-standOff-constraint-nested_standOff_should_be_typed-60">
      <rule context="tei:standOff">
         <assert test="@type or not(ancestor::tei:standOff)">This
      <name/> element must have a @type attribute, since it is
      nested inside a <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="tei_all-att.repeatable-constraint-MINandMAXoccurs-61">
      <rule context="*[ @minOccurs  and  @maxOccurs ]">
        <let name="min" value="@minOccurs cast as xs:integer"/>
        <let name="max"
              value="if ( normalize-space( @maxOccurs ) eq 'unbounded')                         then -1                         else @maxOccurs cast as xs:integer"/>
        <assert test="$max eq -1  or  $max ge $min">@maxOccurs should be greater than or equal to @minOccurs</assert>
      </rule>
      <rule context="*[ @minOccurs  and  not( @maxOccurs ) ]">
        <assert test="@minOccurs cast as xs:integer lt 2">When @maxOccurs is not specified, @minOccurs must be 0 or 1</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-att.identified-constraint-spec-in-module-62">
      <rule context="tei:elementSpec[@module]|tei:classSpec[@module]|tei:macroSpec[@module]">
        <assert test="         (not(ancestor::tei:schemaSpec | ancestor::tei:TEI | ancestor::tei:teiCorpus)) or         (not(@module) or          (not(//tei:moduleSpec) and not(//tei:moduleRef))  or         (//tei:moduleSpec[@ident = current()/@module]) or          (//tei:moduleRef[@key = current()/@module]))         ">
        Specification <value-of select="@ident"/>: the value of the module attribute ("<value-of select="@module"/>") 
should correspond to an existing module, via a moduleSpec or
      moduleRef</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-att.deprecated-validUntil-constraint-deprecation-two-month-warning-63">
      <rule context="tei:*[@validUntil]">
            <let name="advance_warning_period"
              value="current-date() + xs:dayTimeDuration('P60D')"/>
            <let name="me_phrase"
              value="if (@ident)                                                then concat('The ', @ident )                                                else concat('This ',                                                            local-name(.),                                                            ' of ',                                                            ancestor::tei:*[@ident][1]/@ident )"/>
            <assert test="@validUntil cast as xs:date  ge  current-date()">
              <value-of select="                  concat( $me_phrase,                          ' construct is outdated (as of ',                          @validUntil,                          '); ODD processors may ignore it, and its use is no longer supported'                        )"/>
         </assert>
              <assert role="nonfatal"
                 test="@validUntil cast as xs:date  ge  $advance_warning_period">
                <value-of select="concat( $me_phrase, ' construct becomes outdated on ', @validUntil )"/>
              </assert>
          </rule>
   </pattern>
   <pattern id="tei_all-att.deprecated-validUntil-constraint-deprecation-should-be-explained-64">
      <rule context="tei:*[@validUntil][ not( self::valDesc | self::valList | self::defaultVal )]">
            <assert test="child::tei:desc[ @type eq 'deprecationInfo']">
              A deprecated construct should include, whenever possible, an explanation, but this <value-of select="name(.)"/> does not have a child &lt;desc type="deprecationInfo"&gt;</assert>
          </rule>
   </pattern>
   <pattern id="tei_all-moduleRef-constraint-modref-65">
      <rule context="tei:moduleRef">
        <report test="* and @key">
Child elements of <name/> are only allowed when an external module is being loaded
        </report>
      </rule>
   </pattern>
   <pattern id="tei_all-moduleRef-prefix-constraint-not-same-prefix-66">
      <rule context="tei:moduleRef">
            <report test="//*[ not( generate-id(.) eq generate-id(      current() ) ) ]/@prefix = @prefix">The prefix attribute
	    of <name/> should not match that of any other
	    element (it would defeat the purpose)</report>
          </rule>
   </pattern>
   <pattern id="tei_all-schemaSpec-constraint-deprecate_schemaSpec_in_bizarre_places-67">
      <rule context="tei:schemaSpec|teix:schemaSpec">
	        <assert test="             parent::teix:egXML      | parent::tei:encodingDesc  | parent::teix:encodingDesc      | parent::tei:front         | parent::teix:front      | parent::tei:back          | parent::teix:back      | parent::tei:body          | parent::teix:body      | parent::tei:div           | parent::teix:div      | parent::tei:div1          | parent::teix:div1      | parent::tei:div2          | parent::teix:div2      | parent::tei:div3          | parent::teix:div3      | parent::tei:div4          | parent::teix:div4      | parent::tei:div5          | parent::teix:div5      | parent::tei:div6          | parent::teix:div6      | parent::tei:div7          | parent::teix:div7"
                 role="nonfatal">WARNING: use of deprecated construct — the “schemaSpec” element will no longer be a valid child of “<value-of select="name(..)"/>” as of 2021-10-23; instead, it should be a child of “front”, “body”, “back”, “encodingDesc”, or a division element.</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-elementSpec-constraint-child-constraint-based-on-mode-68">
      <rule context="tei:elementSpec[ @mode eq 'delete' ]">
        <report test="child::*">This elementSpec element has a mode= of "delete" even though it has child elements. Change the mode= to "add", "change", or "replace", or remove the child elements.</report>
      </rule>
      <rule context="tei:elementSpec[ @mode = ('add','change','replace') ]">
        <assert test="child::* | (@* except (@mode, @ident))">This elementSpec element has a mode= of "<value-of select="@mode"/>", but does not have any child elements or schema-changing attributes. Specify child elements, use validUntil=, predeclare=, ns=, or prefix=, or change the mode= to "delete".</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-model-constraint-no_dup_default_models-69">
      <rule context="tei:model[ not( parent::tei:modelSequence ) ][ not( @predicate ) ]">
        <let name="output" value="normalize-space( @output )"/>
        <report test="following-sibling::tei:model                             [ not( @predicate )]                             [ normalize-space( @output ) eq $output ]">
          There are 2 (or more) 'model' elements in this '<value-of select="local-name(..)"/>'
          that have no predicate, but are targeted to the same output
          ("<value-of select="( $output, parent::modelGrp/@output, 'all')[1]"/>")</report>
      </rule>
   </pattern>
   <pattern id="tei_all-model-constraint-no_dup_models-70">
      <rule context="tei:model[ not( parent::tei:modelSequence ) ][ @predicate ]">
        <let name="predicate" value="normalize-space( @predicate )"/>
        <let name="output" value="normalize-space( @output )"/>
        <report test="following-sibling::tei:model                             [ normalize-space( @predicate ) eq $predicate ]                             [ normalize-space( @output ) eq $output ]">
          There are 2 (or more) 'model' elements in this
          '<value-of select="local-name(..)"/>' that have
          the same predicate, and are targeted to the same output
          ("<value-of select="( $output, parent::modelGrp/@output, 'all')[1]"/>")</report>
      </rule>
   </pattern>
   <pattern id="tei_all-modelSequence-constraint-no_outputs_nor_predicates_4_my_kids-71">
      <rule context="tei:modelSequence">
         <report test="tei:model[@output]" role="warning">The 'model' children
      of a 'modelSequence' element inherit the @output attribute of the
      parent 'modelSequence', and thus should not have their own</report>
      </rule>
   </pattern>
   <pattern id="tei_all-sequence-constraint-sequencechilden-72">
      <rule context="tei:sequence">
         <assert test="count(*)&gt;1">The sequence element must have at least two child elements</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-alternate-constraint-alternatechilden-73">
      <rule context="tei:alternate">
         <assert test="count(*)&gt;1">The alternate element must have at least two child elements</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-constraintSpec-constraint-sch_no_more-74">
      <rule context="tei:constraintSpec">
         <report test="tei:constraint/s:*  and  @scheme = ('isoschematron','schematron')">Rules
        in the Schematron 1.* language must be inside a constraintSpec
        with a value other than 'schematron' or 'isoschematron' on the
        scheme attribute</report>
      </rule>
   </pattern>
   <pattern id="tei_all-constraintSpec-constraint-isosch-75">
      <rule context="tei:constraintSpec">
         <report test="tei:constraint/sch:*  and  not( @scheme eq 'schematron')">Rules
        in the ISO Schematron language must be inside a constraintSpec
        with the value 'schematron' on the scheme attribute</report>
      </rule>
   </pattern>
   <pattern id="tei_all-constraintSpec-constraint-needrules-76">
      <rule context="tei:macroSpec/tei:constraintSpec[@scheme eq 'schematron']/tei:constraint">
        <report test="sch:assert|sch:report">An ISO Schematron constraint specification for a macro should not
        have an 'assert' or 'report' element without a parent 'rule' element</report>
      </rule>
   </pattern>
   <pattern id="tei_all-attDef-constraint-attDefContents-77">
      <rule context="tei:attDef">
         <assert test="ancestor::teix:egXML[@valid='feasible'] or @mode eq 'change' or @mode eq 'delete' or tei:datatype or tei:valList[@type='closed']">Attribute: the definition of the @<value-of select="@ident"/> attribute in the <value-of select="ancestor::*[@ident][1]/@ident"/>
            <value-of select="' '"/>
            <value-of select="local-name(ancestor::*[@ident][1])"/> should have a closed valList or a datatype</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-attDef-constraint-noDefault4Required-78">
      <rule context="tei:attDef[@usage eq 'req']">
	        <report test="tei:defaultVal">Since the @<value-of select="@ident"/> attribute is required, it will always be specified. Thus the default value (of "<value-of select="normalize-space(tei:defaultVal)"/>") will never be used. Either change the definition of the attribute so it is not required ("rec" or "opt"), or remove the defaultVal element.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-attDef-constraint-defaultIsInClosedList-twoOrMore-79">
      <rule context="tei:attDef[   tei:defaultVal   and   tei:valList[@type eq 'closed']   and   tei:datatype[    @maxOccurs &gt; 1    or    @minOccurs &gt; 1    or    @maxOccurs = 'unbounded'    ]   ]">
        <assert test="     tokenize(normalize-space(tei:defaultVal),' ')     =     tei:valList/tei:valItem/@ident">In the <value-of select="local-name(ancestor::*[@ident][1])"/> defining
        <value-of select="ancestor::*[@ident][1]/@ident"/> the default value of the
        @<value-of select="@ident"/> attribute is not among the closed list of possible
        values</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-attDef-constraint-defaultIsInClosedList-one-80">
      <rule context="tei:attDef[   tei:defaultVal   and   tei:valList[@type eq 'closed']   and   tei:datatype[    not(@maxOccurs)    or (    if ( @maxOccurs castable as xs:integer )     then ( @maxOccurs cast as xs:integer eq 1 )     else false()    )]   ]">
        <assert test="string(tei:defaultVal)      =      tei:valList/tei:valItem/@ident">In the <value-of select="local-name(ancestor::*[@ident][1])"/> defining
        <value-of select="ancestor::*[@ident][1]/@ident"/> the default value of the
        @<value-of select="@ident"/> attribute is not among the closed list of possible
        values</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-dataRef-constraint-restrictDataFacet-81">
      <rule context="tei:dataRef[tei:dataFacet]">
        <assert test="@name" role="nonfatal">Data facets can only be specified for references to datatypes specified by
          XML Schemas: Part 2: Datatypes</assert>
      </rule>
   </pattern>
   <pattern id="tei_all-dataRef-constraint-restrictAttRestriction-82">
      <rule context="tei:dataRef[tei:dataFacet]">
        <report test="@restriction" role="nonfatal">The attribute restriction cannot be used when dataFacet elements are present.</report>
      </rule>
   </pattern>
   <pattern id="tei_all-dataRef-constraint-restrictAttResctrictionName-83">
      <rule context="tei:dataRef">
        <report test="@restriction and not(@name)" role="fatal">The attribute restriction can only be used with a name attribute.</report>
      </rule>
   </pattern>
</schema>
