﻿Type.registerNamespace('AjaxControlToolkit');AjaxControlToolkit.BehaviorBase = function(element) {
AjaxControlToolkit.BehaviorBase.initializeBase(this,[element]);this._clientStateFieldID = null;this._pageRequestManager = null;this._partialUpdateBeginRequestHandler = null;this._partialUpdateEndRequestHandler = null;}
AjaxControlToolkit.BehaviorBase.prototype = {
initialize : function() {
AjaxControlToolkit.BehaviorBase.callBaseMethod(this, 'initialize');},
dispose : function() {
AjaxControlToolkit.BehaviorBase.callBaseMethod(this, 'dispose');if (this._pageRequestManager) {
if (this._partialUpdateBeginRequestHandler) {
this._pageRequestManager.remove_beginRequest(this._partialUpdateBeginRequestHandler);this._partialUpdateBeginRequestHandler = null;}
if (this._partialUpdateEndRequestHandler) {
this._pageRequestManager.remove_endRequest(this._partialUpdateEndRequestHandler);this._partialUpdateEndRequestHandler = null;}
this._pageRequestManager = null;}
},
get_ClientStateFieldID : function() {
return this._clientStateFieldID;},
set_ClientStateFieldID : function(value) {
if (this._clientStateFieldID != value) {
this._clientStateFieldID = value;this.raisePropertyChanged('ClientStateFieldID');}
},
get_ClientState : function() {
if (this._clientStateFieldID) {
var input = document.getElementById(this._clientStateFieldID);if (input) {
return input.value;}
}
return null;},
set_ClientState : function(value) {
if (this._clientStateFieldID) {
var input = document.getElementById(this._clientStateFieldID);if (input) {
input.value = value;}
}
},
registerPartialUpdateEvents : function() {
if (Sys && Sys.WebForms && Sys.WebForms.PageRequestManager){
this._pageRequestManager = Sys.WebForms.PageRequestManager.getInstance();if (this._pageRequestManager) {
this._partialUpdateBeginRequestHandler = Function.createDelegate(this, this._partialUpdateBeginRequest);this._pageRequestManager.add_beginRequest(this._partialUpdateBeginRequestHandler);this._partialUpdateEndRequestHandler = Function.createDelegate(this, this._partialUpdateEndRequest);this._pageRequestManager.add_endRequest(this._partialUpdateEndRequestHandler);}
}
},
_partialUpdateBeginRequest : function(sender, beginRequestEventArgs) {
},
_partialUpdateEndRequest : function(sender, endRequestEventArgs) {
}
}
AjaxControlToolkit.BehaviorBase.registerClass('AjaxControlToolkit.BehaviorBase', Sys.UI.Behavior);AjaxControlToolkit.DynamicPopulateBehaviorBase = function(element) {
AjaxControlToolkit.DynamicPopulateBehaviorBase.initializeBase(this, [element]);this._DynamicControlID = null;this._DynamicContextKey = null;this._DynamicServicePath = null;this._DynamicServiceMethod = null;this._dynamicPopulateBehavior = null;this._populatingHandler = null;this._populatedHandler = null;}
AjaxControlToolkit.DynamicPopulateBehaviorBase.prototype = {
initialize : function() {
AjaxControlToolkit.DynamicPopulateBehaviorBase.callBaseMethod(this, 'initialize');this._populatingHandler = Function.createDelegate(this, this._onPopulating);this._populatedHandler = Function.createDelegate(this, this._onPopulated);},
dispose : function() {
if (this._populatedHandler) {
if (this._dynamicPopulateBehavior) {
this._dynamicPopulateBehavior.remove_populated(this._populatedHandler);}
this._populatedHandler = null;}
if (this._populatingHandler) {
if (this._dynamicPopulateBehavior) {
this._dynamicPopulateBehavior.remove_populating(this._populatingHandler);}
this._populatingHandler = null;}
if (this._dynamicPopulateBehavior) {
this._dynamicPopulateBehavior.dispose();this._dynamicPopulateBehavior = null;}
AjaxControlToolkit.DynamicPopulateBehaviorBase.callBaseMethod(this, 'dispose');},
populate : function(contextKeyOverride) {
if (this._dynamicPopulateBehavior && (this._dynamicPopulateBehavior.get_element() != $get(this._DynamicControlID))) {
this._dynamicPopulateBehavior.dispose();this._dynamicPopulateBehavior = null;}
if (!this._dynamicPopulateBehavior && this._DynamicControlID && this._DynamicServiceMethod) {
this._dynamicPopulateBehavior = $create(AjaxControlToolkit.DynamicPopulateBehavior, {"id":this.get_id()+"_DynamicPopulateBehavior", "ContextKey":this._DynamicContextKey, "ServicePath":this._DynamicServicePath, "ServiceMethod":this._DynamicServiceMethod }, null, null, $get(this._DynamicControlID));this._dynamicPopulateBehavior.add_populating(this._populatingHandler);this._dynamicPopulateBehavior.add_populated(this._populatedHandler);}
if(this._dynamicPopulateBehavior) {
this._dynamicPopulateBehavior.populate(contextKeyOverride ? contextKeyOverride : this._DynamicContextKey);}
},
_onPopulating : function(sender, eventArgs) {
},
_onPopulated : function(sender, eventArgs) {
},
get_DynamicControlID : function() {
return this._DynamicControlID;},
set_DynamicControlID : function(value) {
if (this._DynamicControlID != value) {
this._DynamicControlID = value;this.raisePropertyChanged('DynamicControlID');}
},
get_DynamicContextKey : function() {
return this._DynamicContextKey;},
set_DynamicContextKey : function(value) {
if (this._DynamicContextKey != value) {
this._DynamicContextKey = value;this.raisePropertyChanged('DynamicContextKey');}
},
get_DynamicServicePath : function() {
return this._DynamicServicePath;},
set_DynamicServicePath : function(value) {
if (this._DynamicServicePath != value) {
this._DynamicServicePath = value;this.raisePropertyChanged('DynamicServicePath');}
},
get_DynamicServiceMethod : function() {
return this._DynamicServiceMethod;},
set_DynamicServiceMethod : function(value) {
if (this._DynamicServiceMethod != value) {
this._DynamicServiceMethod = value;this.raisePropertyChanged('DynamicServiceMethod');}
}
}
AjaxControlToolkit.DynamicPopulateBehaviorBase.registerClass('AjaxControlToolkit.DynamicPopulateBehaviorBase', AjaxControlToolkit.BehaviorBase);AjaxControlToolkit.ControlBase = function(element) {
AjaxControlToolkit.ControlBase.initializeBase(this, [element]);this._clientStateField = null;this._callbackTarget = null;this._onsubmit$delegate = Function.createDelegate(this, this._onsubmit);this._oncomplete$delegate = Function.createDelegate(this, this._oncomplete);this._onerror$delegate = Function.createDelegate(this, this._onerror);}
AjaxControlToolkit.ControlBase.prototype = {
initialize : function() {
AjaxControlToolkit.ControlBase.callBaseMethod(this, "initialize");if (this._clientStateField) {
this.loadClientState(this._clientStateField.value);}
if (typeof(Sys.WebForms)!=="undefined" && typeof(Sys.WebForms.PageRequestManager)!=="undefined") {
Array.add(Sys.WebForms.PageRequestManager.getInstance()._onSubmitStatements, this._onsubmit$delegate);} else {
$addHandler(document.forms[0], "submit", this._onsubmit$delegate);}
},
dispose : function() {
if (typeof(Sys.WebForms)!=="undefined" && typeof(Sys.WebForms.PageRequestManager)!=="undefined") {
Array.remove(Sys.WebForms.PageRequestManager.getInstance()._onSubmitStatements, this._onsubmit$delegate);} else {
$removeHandler(document.forms[0], "submit", this._onsubmit$delegate);}
AjaxControlToolkit.ControlBase.callBaseMethod(this, "dispose");},
findElement : function(id) {
return $get(this.get_id() + '_' + id.split(':').join('_'));},
get_clientStateField : function() {
return this._clientStateField;},
set_clientStateField : function(value) {
if (this.get_isInitialized()) throw Error.invalidOperation(AjaxControlToolkit.Resources.ExtenderBase_CannotSetClientStateField);this._clientStateField = value;},
loadClientState : function(value) {
},
saveClientState : function() {
return null;},
_invoke : function(name, args, cb) {
if (!this._callbackTarget) {
throw Error.invalidOperation(AjaxControlToolkit.Resources.ExtenderBase_ControlNotRegisteredForCallbacks);}
if (typeof(WebForm_DoCallback)==="undefined") {
throw Error.invalidOperation(AjaxControlToolkit.Resources.ExtenderBase_PageNotRegisteredForCallbacks);}
var ar = [];for (var i = 0;i < args.length;i++) 
ar[i] = args[i];var clientState = this.saveClientState();if (clientState != null && !String.isInstanceOfType(clientState)) {
throw Error.invalidOperation(AjaxControlToolkit.Resources.ExtenderBase_InvalidClientStateType);}
var payload = Sys.Serialization.JavaScriptSerializer.serialize({name:name,args:ar,state:this.saveClientState()});WebForm_DoCallback(this._callbackTarget, payload, this._oncomplete$delegate, cb, this._onerror$delegate, true);},
_oncomplete : function(result, context) {
result = Sys.Serialization.JavaScriptSerializer.deserialize(result);if (result.error) {
throw Error.create(result.error);}
this.loadClientState(result.state);context(result.result);},
_onerror : function(message, context) {
throw Error.create(message);},
_onsubmit : function() {
if (this._clientStateField) {
this._clientStateField.value = this.saveClientState();}
return true;} 
}
AjaxControlToolkit.ControlBase.registerClass("AjaxControlToolkit.ControlBase", Sys.UI.Control);
Type.registerNamespace('AjaxControlToolkit');
AjaxControlToolkit.Resources={
"TextCount_DefaultKeyboardModeFormat":"Keyboard Mode: {3}",
"PasswordStrength_InvalidWeightingRatios":"Strength Weighting ratios must have 4 elements",
"Animation_ChildrenNotAllowed":"AjaxControlToolkit.Animation.createAnimation cannot add child animations to type \"{0}\" that does not derive from AjaxControlToolkit.Animation.ParentAnimation",
"PasswordStrength_RemainingSymbols":"{0} symbol characters",
"ExtenderBase_CannotSetClientStateField":"clientStateField can only be set before initialization",
"Animation_TargetNotFound":"AjaxControlToolkit.Animation.Animation.set_animationTarget requires the ID of a Sys.UI.DomElement or Sys.UI.Control.  No element or control could be found corresponding to \"{0}\"",
"TextCount_DefaultAlertFormat":"Maximum length is {2}",
"Common_InvalidBorderWidthUnit":"A unit type of \"{0}\"\u0027 is invalid for parseBorderWidth",
"Tabs_PropertySetBeforeInitialization":"{0} cannot be changed before initialization",
"ReorderList_DropWatcherBehavior_NoChild":"Could not find child of list with id \"{0}\"",
"CascadingDropDown_MethodTimeout":"[Method timeout]",
"ExtenderBase_PageNotRegisteredForCallbacks":"This Page has not been registered for callbacks",
"Animation_NoDynamicPropertyFound":"AjaxControlToolkit.Animation.createAnimation found no property corresponding to \"{0}\" or \"{1}\"",
"Animation_InvalidBaseType":"AjaxControlToolkit.Animation.registerAnimation can only register types that inherit from AjaxControlToolkit.Animation.Animation",
"ResizableControlBehavior_InvalidHandler":"{0} handler not a function, function name, or function text",
"Animation_InvalidColor":"Color must be a 7-character hex representation (e.g. #246ACF), not \"{0}\"",
"PasswordStrength_RemainingMixedCase":"Mixed case characters",
"CascadingDropDown_NoParentElement":"Failed to find parent element \"{0}\"",
"ValidatorCallout_DefaultErrorMessage":"This control is invalid",
"ReorderList_DropWatcherBehavior_CallbackError":"Reorder failed, see details below.\\r\\n\\r\\n{0}",
"PopupControl_NoDefaultProperty":"No default property supported for control \"{0}\" of type \"{1}\"",
"PopupExtender_NoParentElement":"Couldn\u0027t find parent element \"{0}\"",
"TextCount_DefaultOverwriteText":"Overwrite",
"PasswordStrength_RemainingNumbers":"{0} more numbers",
"ResizableControlBehavior_CannotChangeProperty":"Changes to {0} not supported",
"TextCount_DefaultDisplayFormat":"Count: {0} Remaining chars: {1} Maximum length: {2}",
"Common_InvalidPaddingUnit":"A unit type of \"{0}\" is invalid for parsePadding",
"ExtenderBase_ControlNotRegisteredForCallbacks":"This Control has not been registered for callbacks",
"Calendar_Today":"Today: {0}",
"Common_DateTime_InvalidFormat":"Invalid format",
"ListSearch_DefaultPrompt":"Type to search",
"CollapsiblePanel_NoControlID":"Failed to find element \"{0}\"",
"PasswordStrength_DefaultStrengthDescriptions":"NonExistent;Very Weak;Weak;Poor;Almost OK;Barely Acceptable;Average;Good;Strong;Excellent;Unbreakable!",
"Animation_UknownAnimationName":"AjaxControlToolkit.Animation.createAnimation could not find an Animation corresponding to the name \"{0}\"",
"ExtenderBase_InvalidClientStateType":"saveClientState must return a value of type String",
"Rating_CallbackError":"An unhandled exception has occurred:\\r\\n{0}",
"Tabs_OwnerExpected":"owner must be set before initialize",
"DynamicPopulate_WebServiceTimeout":"Web service call timed out",
"Animation_MissingAnimationName":"AjaxControlToolkit.Animation.createAnimation requires an object with an AnimationName property",
"Tabs_ActiveTabArgumentOutOfRange":"Argument is not a member of the tabs collection",
"AlwaysVisible_ElementRequired":"AjaxControlToolkit.AlwaysVisibleControlBehavior must have an element",
"Slider_NoSizeProvided":"Please set valid values for the height and width attributes in the slider\u0027s CSS classes",
"DynamicPopulate_WebServiceError":"Web Service call failed: {0}",
"PasswordStrength_StrengthPrompt":"Strength: ",
"PasswordStrength_RemainingCharacters":"{0} more characters",
"PasswordStrength_Satisfied":"Nothing more required",
"Animation_NoPropertyFound":"AjaxControlToolkit.Animation.createAnimation found no property corresponding to \"{0}\"",
"TextCount_DefaultInsertText":"Insert",
"PasswordStrength_GetHelpRequirements":"Get help on password requirements",
"PasswordStrength_InvalidStrengthDescriptions":"Invalid number of text strength descriptions specified",
"Tabs_PropertySetAfterInitialization":"{0} cannot be changed after initialization",
"CascadingDropDown_MethodError":"[Method error {0}]",
"Common_UnitHasNoDigits":"No digits",
"Common_DateTime_InvalidTimeSpan":"\"{0}\" is not a valid TimeSpan format",
"Animation_CannotNestSequence":"AjaxControlToolkit.Animation.SequenceAnimation cannot be nested inside AjaxControlToolkit.Animation.ParallelAnimation",
"Shared_BrowserSecurityPreventsPaste":"Your browser security settings don\u0027t permit the automatic execution of paste operations. Please use the keyboard shortcut Ctrl+V instead."
};

if(typeof(Sys)!=='undefined')Sys.Application.notifyScriptLoaded();