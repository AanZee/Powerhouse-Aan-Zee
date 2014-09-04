# Front-end Powerhouse Methodology — Aan Zee

*Opinionated guide for front-end development and infrastructure of medium sized web projects curated by [Aan Zee Interactive](http://www.aanzee.nl/)*

The Front-end Powerhouse Methodology (FPM) — Ain't we all love a good abbreviation — is meant for small agile team who want to up their game and turn into a Front-end Powerhouse. In this methodology the following principles are embraced:
- Don't Repeat Yourself (DRY)
- Keep It Simple Stupid (KISS)
- Convention over configuration
- Legibility over performance

[Not quite sure if you know about the DRY and KISS principles?](http://code.tutsplus.com/tutorials/3-key-software-principles-you-must-understand--net-25161)

## Roles inside a team

Alongside this core principles FPM also makes a bunch of assumptions about the roles inside a team, although this does not mean a team can't contain more roles. Also a single person may cover more than one role. The following roles are defined:

### Front-end designer

Someone who used to start his work in Photoshop and is often labelled as (online) designer or (online) Art Director within an organisation. His or her best ideas often evolve from a paper moleskin. The role within a team is often to create style tiles, convert wireframes into markup, write styles and create basic Javascript interactions.

More focused on the design, the Front-end designer might sometimes miss out or forgot some best practices and make structural mistakes which prove hard to revert later on. The person within this role will need validation and guidance from a front-end developer to make sure he uses the right techniques.

**Tips**
- Use Simple markup for the back-end to convert to dynamic views
- Annotate the code when there are exceptions or peculiarities
- Test with real content

### Front-end developer

In the case of FPM the Front-end developer should be the evangelist of this methodology and try to help the team as much as possible to follow the guidelines. The Front-end developer feels right at home with Mark-up, styling and Javascript and this are also his core responsibilities.

The Front-end developer should be less concerned about design when a Front-end Designer is on the team. However the developer should not leave design work to his team members. Instead the Front-end developer should discuss with the designer what choices to make so he will complete the component when it is still fresh in his mind, avoiding the need for the designer to familiarise with this part of the project and make the desired adjustments.

When a Front-end Designer is on the team, the developer should also take responsibility over code infrastructure, code simplification/optimisation and assist any team member in the Front-end Designer role or Back-end developer role.

**Tips**
- Don't neglect design
- Support Front-end designers

## Back-end developer

Most of the times the Back-end developer is most distant from the actual design, often doing only adjustments purely in code. In the case of FPM his role mainly consists out of turning static HTMl into dynamic views. Often the Back-end developer is also last in the chain and sometimes design details are left unnoticed, such as class names which address state or other peculiarities.

If you think markup is incorrect, or the design doesn't support the actual content very well? Ask a Front-end Designer/Developer.

**Tips:**
- Don't forgot to check out the actual result in the browser
- Test with real content


# All about styles

FPM promotes a BEM inspired subset called BEMS. This BEM inspired syntax can help to make code clearer and combat complex selector structures. The aim should be developer speed, the following steps should be optimised for developer speed.

How fast can a developer:
- Inspect an element and spot what selector(s) to change;
- find the designated file(s);
- update the desired properties;
- validate if the update is compatible with the rest of the project

### Writing selectors

Deeply nested selectors which are tightly coupled to the markup are generally avoided. First, it's hard to reverse engineer long compiled selectors from the "Inspect Element" pane.

*Example of deeply nested selector*
```SCSS
// Avoid this
.form .form-row {
	.select-container {
		> p > a {
			text-decoration: none;
		}
	}
}
```

Second, any new styles must be even more specific, resulting in a vicious circle of over specifying selectors. Especially true for different break points.

```SCSS
// BE EVIL
.form .form-row .select-container > p > a.link--underline {
	text-decoration: underline;
}
```

Third, the difficulty of finding out how to update a piece of code may result in neglect this code and in addition may cause cutting corners when deadlines are tight.

```SCSS
// BE EVIL 2.0
a.underline {
	text-decoration: underline !important;
}
```

Rulesets should only ever inherit and add to previous ones, never undo.

Any declarations like these:

```SCSS
border-bottom: none;
padding: 0;
float: none;
margin: 0;
```

...should be avoided because you applied theme somewhere before.

## BEMS: the Good, the Bad and the Ugly

*Aan Zee implements only a small subset of BEM, and differs in the syntax. `block--element__modifier` instead `block__element--modifier`*

In a nutshell BEMS is a set of naming convetions which gives developers the power to explicitly give meaning to a name and better describe complex structures. Immediate gains of BEMS are simpler styles, better notation of element dependencies and faster offloading of the mind, since you don't need to worry so much a name is already used or taken.

The difference between BEMS and BEM is that BEMS seperates Modifiers from States, which allows for an better symbioses between back-end developers and Javascript developers.

To better understand BEM [watch this Slide Share presentation](http://www.slideshare.net/MaxShirshin/bem-dm).

This presentation gives examples with prefixes for Blocks -> b- and Elements -> e-, however this is not a necessity since this guide promotes only a subset of BEM. Some of the most important parts of the aforementioned presentation are highlighted below.

BEMS stands for Block, Element, Modifier, States

*Block* `block`
– Standalone part of an interface:
  - button
  - text field
  - flyout
  - heading
  - menu
- Re-usable in different contexts
- Self-sufficient

*Element* `block--element`
- An integral part of a Block
  - button (contains no elements)
  - text field -> label
  - flyout -> title
  - heading -> logo
  - menu -> item
- No standalone meaning outside of a block
- Some blocks have no elements

*Modifier* `block--element__modifier`
- Defines property on a block or element
  - button *theme*
  - flyout *alignment*
  - heading *level*
  - menu -> item *bullet type*
- Multiple modifiers may co-exist on a single block/element

*States*
- Defines what state a block or element is in
- States are not prefixed with the block or element
  - is-active
  - is-shown
  - has-content
- States are often booleans and should follow the appropiate naming convention
  - Prefix boolean stateswith is-/has-
  - Prefer is- over has-

### How does BEM map to DOM?

- Block, Elements, Modifiers are denoted with CSS classes using a naming convention
- Dom nodes can be shared:
  - block1 + block2 may occupy the same container;
  - element1 + block2 may co-exist on the same node
- Dom is encapsulated:
  - complex DOM structure may consitute a single element (an element may consist out of more DOM nodes)

### CSS naming conventions

The presentation uses a naming prefix for blocks. However, this is not used for the Powerhouse methodology.

#### Block:
```
.button
.form-row
.flyout
.heading
.hero
.menu
```

Good names for blocks are:
- button
- heading
- hero
- footer
- menu

Example
```HTML
<ul class="menu">
	<li><a href="/1">1</a></li>
	<li><a href="/2">2</a></li>
	<li><a href="/3">3</a></li>
	<li><a href="/4">4</a></li>
</ul>
```

#### Element:
```
.button--icon
.text-field--label
.flyout--title
.heading--logo
.menu--item
```

Good names for elements are:
- icon
- label
- title
- sub-title
- item

Example
```HTML
<ul class="menu">
	<li class="menu--item"><a class="menu--item--link" href="/1">1</a></li>
	<li class="menu--item"><a class="menu--item--link" href="/2">2</a></li>
	<li class="menu--item"><a class="menu--item--link" href="/3">3</a></li>
	<li class="menu--item"><a class="menu--item--link" href="/4">4</a></li>
</ul>
```

#### Modifier:
Note that modifiers uses a somewhat different notation than in the presentation.
```
.button__primary
.flyout__align-top
.menu--item__highlight
```

*How to deal with aligment modifiers is still a grey area.*

Good names for modifiers are:
- primary
- secondary
- tertiary
- highlight
- align-top/right/bottom/left (?)

#### States:
```
.menu--item.is-active
.flyout.is-shown
.sidebar.is-shown
```

```JavaScript
$('.flyout, .sidebar').toggleClass('.is-shown');
```

Example markup
```HTML
<ul class="menu">
	<li class="menu--item is-active"><a class="menu--item--link" href="/1">1</a></li>
	<li class="menu--item"><a class="menu--item--link" href="/2">2</a></li>
	<li class="menu--item"><a class="menu--item--link" href="/3">3</a></li>
	<li class="menu--item"><a class="menu--item--link" href="/4">4</a></li>
</ul>
```


Example in the styles
```SCSS
.menu {}
.menu--item {}
.menu--item--link {
	&:active,
	.is-active & {
		background-color: white;
	}
}
```
*`is-active &` is a trick in Sass to generate `.menu--item.is-active .menu-item--link {}`*

Good names for states are:
- is-shown
- is-active
- is-selected
- is-open
- is-enabled
- has-content (?)

With BEM states are often also the same as modifiers, but FPM favors states without the block or element prefixed. As a convention states *never* have global styling. In addition, boolean states should follow the naming convention of is-/has- prefixes. This practice makes it easy for backenders to spot state and easy for Javascript developers to use simple state classes without being aware of what the name of the block or element is.


```
<ul class="menu">
	<li class="menu--item is-active"><a class="menu--item--link" href="/1">1</a></li>
	<li class="menu--item"><a class="menu--item--link" href="/2">2</a></li>
	<li class="menu--item"><a class="menu--item--link" href="/3">3</a></li>
	<li class="menu--item"><a class="menu--item--link" href="/4">4</a></li>
</ul>
```

### How to apply BEM in SASS

One of the best parts of BEM is the fact you can drop tag names and ID's, and re-use the same semantics on any tag.
```HTML
<div class="block-name"></div>
<span class="block-name"></span>
<table class="block-name"></table>
```

Another benefit is that CSS specifity is almost magically solved by selector order.
```
.article {

}

.article--highlight
```


With BEM there is almost no CSS cascade except with modifiers sometimes.

```SCSS
.menu__dark .menu--item {
	color: white;
}
```

## BEM is ugly!

> A common argument against BEM is that it’s ugly; I dare say that if you shy away from code based purely on its looks then you’re often missing the point. Unless the code becomes unnecessarily difficult to maintain, or genuinely more difficult to read, then perhaps you do need to think twice before using it, but if it ‘just looks odd’ but has a valid purpose, then it should definitely be fully considered before writing it off.
>
> I agree that BEM does look weird, but the power it brings far outweighs any negatives to do with its appearance by an order of magnitude…
>
> BEM may look a little funny – and it might require more typing (most text editors have autocomplete, and gzip will negate any differences in filesize) – but it is so powerful.
[Wrapping your mind around BEM](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/)

The main reason why developers think BEM is ugly is mainly because of the double underscore for elements, block__element. When you get used to this it is actually pretty useful since you have to power to explicitly state something you couldn't do before. In addition, what often is considered nice looking is dot notation — seen in Javascript for object properties for example. However, this notation is not possible in css selector names. When you think about it the only characters you can use to give something extra meaning is the hyphen or the underscore.


Links:
- [Slideshare BEM it! presentation](http://www.slideshare.net/MaxShirshin/bem-dm)
- [Sass maps are awesome](http://viget.com/extend/sass-maps-are-awesome)
- http://bramsmulders.com/how-i-improved-my-workflow-with-smacss-sass.html
- http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/
- http://css-tricks.com/specifics-on-css-specificity/
- [Avoid @extend it slows down projects](http://stackoverflow.com/questions/13546738/rails-sass-compiles-too-slow-in-a-fast-development-machine)
- [Sass content directives](http://robots.thoughtbot.com/sasss-content-directive)

## Module structure

Modern requirements for responsive design give an extra dimension to creating modulair components. The biggest difficulty here is how to create modulair components with CSS (or preprocessor). One approach Aan Zee currently uses is to create modules such as "variables, typography, nav, header" for each of the breakpoints and put them in separate folders:

```

css/
+-- variables.scss
+-- modules/
|   +-- _nav.scss
|   +--_header.scss
|   +-- small/
|   |   +-- _nav.scss
|   |   +-- _header.scss
|   +-- medium/
|   |   +-- _nav.scss
|   |   +-- _header.scss
|   +-- large/
|   |   +-- _nav.scss
|   |   +-- _header.scss
|   +--extra-large/
|   |   +-- _nav.scss
|   |   +-- _header.scss
```

Some advantages of this approach are the initial overview you get when you open the files next to each for a module. Wether a breakpoint contains styles is noticeable at a glance. However, there is a certain bias towards big screens and double screens here, team members with smaller screens might actually experience a disadvantage. Also, opening so many files might be cumbersome at times.

This approach might result in a lot repetition and is not so DRY compared to putting breakpoints in one module file. Factors contributing to this repetition are the fact you need to create 4+ files with the same name, write imports for this 4+ files and open this 4+ files. Another factor is it can easily create a lot of code duplication since breakpoints are often defined with boundaries. Often styles for tablet are the same as for the desktop. This disadvantage directly highlights the flaws of configuration over convention. If the module instead would have breakpoints by convention, it could break those conventions from time to time when necessary and at the same time avoid repetition — since there is just one module file.

### Dealing with media query perfomance in SASS

The argument for combining all styles for a single breakpoint in a single media query is often performance. However, it turns out that browsers optimize media queries internally and it is not a perfomance issue at all, except for when you resize the browser. It is still not possible to create a construct in SASS to combine media queries. Mixins do support a '@content' directive. To combat the perfomance impact of multiple media queries especially in large projects the usage of a [Sass media query combiner](https://github.com/aaronjensen/sass-media_query_combiner)

- [Web Performance: One or thousands of Media Queries?](http://helloanselm.com/2014/web-performance-one-or-thousand-media-queries/)
- [Sass and media queries](http://sasscast.tumblr.com/post/38673939456/sass-and-media-queries)
- [Media query test](http://aaronjensen.github.io/media_query_test/)
- [Stack overflow: Is there an advantage in grouping css media queries together?](http://stackoverflow.com/questions/11626174/is-there-an-advantage-in-grouping-css-media-queries-together)
- [Sass media query combiner](https://github.com/aaronjensen/sass-media_query_combiner)

## Proposed file structure

Inspired by SMACCS and the like. For easy deployment `css` and `scss` should be seperated, no need to upload the sass to the live environment.
```
css/
+-- main.css

scss/
+-- main.scss
+-- _settings.scss
+-- _global.scss
+-- _typograpgy.scss
+-- _reset.scss
+-- _utils.scss
+-- _font-scale.scss
+-- modules/
|   +-- _layout.scss
|   +-- _header.scss
|   +-- _footer.scss
|   +-- _search.scss (*)
|   +-- _gallery.scss (*)
+-- vendor/
|   +-- _some-fancy-plugin.scss (*)

```
*Names appended with a star (*) are examples*

Using names such as style.css seems double since css already implies a style sheet. Instead use a descriptive name to give as much meaning to the file as possible.

### Modules folder
Modules are self-contained styles which apply to a single module. Styles inside modules should try to avoid changing global styles.

### _settings.scss
Contains mainly colour variables which are global. Try to prefix colors with `$color-` Also other variables which need to be global. Don't add variables which are only important to one module.

### _global.scss
Contains style declarations such as body styles, text selection styles and other styles which are considered to be global and can't be added to a single module.

### _reset.scss


### _utils.scss
Contain mixins and functions which are global to the project. Try to make them as generic and re-usable as possible, so other projects can re-use them.


### Typography

Contains a font scale with mixins inspirid by the article [setting typographic scale with sass maps](http://erskinedesign.com/blog/setting-typographic-scale-with-sass-maps/). Instead of exposing classnames, styling headers is done in the SASS.

```SCSS
.header--title {
	@include font-scale(1, $font-helvetica);
}
```

#### Adding fonts

Inside the fonts folder all requirements for a single font are available, this includes the font files and a sass file to import the font. To create a font simply create a new folder with the font name with a `_font-settings.scss` file inside

Example with the Meta font
```
fonts/
+-- meta/
|   _font-settings.scss
|   MetaWeb-Bold.eot
|   MetaWeb-Bold.woff
|   MetaWeb-Bolditalic.eot
|   MetaWeb-Bolditalic.woff
|   MetaWeb-Light.eot
|   MetaWeb-Light.woff
|   MetaWeb-Medium.eot
|   MetaWeb-Medium.woff
|   MetaWeb-Normal.eot
|   MetaWeb-Normal.woff
|   MetaWeb-Normalitalic.eot
|   MetaWeb-Normalitalic.woff
```

#### Font scales

Inside the `_font-scales.scss` file should contain a map variable prefixed with `$font-{name of font}`. In the case of Meta it would be `$font-meta`.

Example `_font-scales.scss` for the Meta font:
```SCSS
$font-meta: (
	stack: "Meta, sans-serif",
	1: (
		font-size: 11px,
		line-height: 18px
	),
	2: (
		font-size: 13px,
		line-height: 18px
	),
	3: (
		font-size: 15px,
		line-height: 21px
	),
	4: (
		font-size: 18px,
		line-height: 27px
	),
	5: (
		font-size: 21px,
		line-height: 35px
	),
	6: (
		font-size: 24px,
		line-height: 37px
	),
	7: (
		font-size: 27px,
		line-height: 42px
	),
	8: (
		font-size: 30px,
		line-height: 39px,
		letter-spacing: -0.2px
	),
	9: (
		font-size: 36px,
		line-height: 45px,
		letter-spacing: -0.2px
	),
	10: (
		font-size: 42px,
		line-height: 48px,
		letter-spacing: -0.2px
	),
	11: (
		font-size: 48px,
		line-height: 57px,
		letter-spacing: -0.4px
	),
	12: (
		font-size: 54px,
		line-height: 60px,
		letter-spacing: -0.6px
	),
	13: (
		font-size: 60px,
		line-height: 69px,
		letter-spacing: -0.6px
	),
	14: (
		font-size: 72px,
		line-height: 72px,
		letter-spacing: -0.6px
	)
);
```

A font map should contain at least 1-14 scale variants and a `stack` property.

To support multiple font variants which share the same font scale you can merge the map already set. `Meta serif` is the perfect example for this.

```SCSS
$font-meta: (
	// ...
);

// First argument is the map you want to copy and overwrite
// Second argument is a map with properties you want to have in your new map
$font-meta-serif: map-merge($font-meta, ( stack: "'Meta serif', serif" ) );
```

# Front-end development of

### File structure
```
wireframes/
+-- index.cfm
prototype/
+-- index.cfm
+-- kitchen-sink.cfm
+-- user-content/
|   +-- article.cfm
|   +-- typography.cfm
|   +-- table.cfm
+-- includes/
|   +-- footer.cfm
|   +-- head.cfm
|   +-- header.cfm
|   +-- hero.cfm
|   +-- scripts.cfm
|   +-- form.cfm
```

### Wireframes

A place for wireframes

### Template directory (replacement of the HTML directory)
Contains boilerplate for the front-end.

### prototype/index.cfm
Contains an overview of the prototype in the directory.


### Kitchen sink
Inside the kitchen sink there is a overview of elements that often require styling, such as typography and tables. New elements such as notifications are a handy addition to the kitchen sink when they are made.

## ColdFusion for supercharging front-end development
There are a handful of CF tags which make front-end development faster and often stop the need for repitition.


### CFM files
All `.cfm` files should have a `<cfoutput></cfoutput>` tag around it's content.

### Cfmodule tag

A cfmodule tag is similar to an include. However, a cfmodule tag supports attributes you can pass to the module. Most commonly this attributes will be strings or booleans. Inside template there could be a file homepage.cfm which contains this line.
```ColdFusion
<head>
	<cfmodule template="includes/head.cfm" title="A page title">
</head>
```

The includes/head.cfm would look like this:
```ColdFusion
<cfoutput>
	<title>#attributes.title#</title>
</cfoutput>
```

Somethings you should take note of
- Attributes are accessible on the attributes struct
- Check if attributes exist with `StructKeyExists(attributes, "attribute")`

*More about cfmodule*
- https://www.adobe.com/support/ultradev/content/cf_custom_tag/cf_custom_tag03.html

### Cfsavecontent tagx

Inside your page file
```ColdFusion
<cfsavecontent variable="headerContent">
	<h1 class="header__title"></h1>
	<h2 class="header__sub-title"></h2>
	<p class="header__intro">

	</p>
</cfsavecontent>
<cfmodule template="includes/header.cfm" content="#headerContent#"/>
```

Inside you header.cfm, by convention use the `content` attribute.
```ColdFusion
<cfoutput>
	<header>
		#attributes.content#
	</header>
</cfoutput>
```

### Cfloop


