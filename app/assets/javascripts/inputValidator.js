(function() {
    /*
     * key: value pair for validationType: corresponding regex.
     */
    var patterns = {
        "telephone": /^\+([0-9]{2})\-([0-9]{10})$/,
        "multiEmail": /^(([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})+\,(\s)?)*(([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4}))+$/,
        "singleEmail": /^(([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4}))+$/,
        "onlyLetters": /^[a-zA-Z ]*$/,
        "onlyNumbers": /^[0-9]+$/,
        "url": /^(ht|f)tps?:\/\/[a-z0-9-\.]+\.[a-z]{2,4}\/?([^\s<>\#%"\,\{\}\\|\\\^\[\]`]+)?$/
    };

    /*
     * key: value pair for validationType: corresponding info/error message.
     */
    var messages = {
        "telephone": "Please enter valid telephone number",
        "singleEmail": "Invalid email address",
        "multiEmail": "Invalid email address, you can add multiple ',' separated addresses",
        "onlyLetters": "Only letters allowed",
        "onlyNumbers": "Only numbers allowed",
        "url": "Please enter valid URL"
    };

    var messageContainer = 
        '<div class="reqformError formError" style="opacity: 0.87; position: absolute; margin-top: -33px;">' +
          '<div class="formErrorContent">' +
          '</div>' +
          '<div class="formErrorArrow">' +
            '<div class="line10">' +
            '</div>' +
            '<div class="line9">' +
            '</div>' +
            '<div class="line8">' +
            '</div>' +
            '<div class="line7">' +
            '</div>' +
            '<div class="line6">' +
            '</div>' +
            '<div class="line5">' +
            '</div>' +
            '<div class="line4">' +
            '</div>' +
            '<div class="line3">' +
            '</div>' +
            '<div class="line2">' +
            '</div>' +
            '<div class="line1">' +
            '</div>' +
          '</div>' +
        '</div>'

    /*
     * Valodator function.
     */
    var inputValidator = function() {
        var iGroup, iGrpElmnts, allIsWell = true, iGrpButtons;

        /*
         * Remove all messages on the page.
         */
        $('.reqformError').remove();
        $('#error-message-container').hide();

        /*
         * Get all elements within same group of current element.
         */
        iGroup = $(this).data("input-group");
        iGrpElmnts = $(".validate");
        /*
         * Get all buttons in current form.
         */
        iGrpButtons = $("." + iGroup + "-validate");
        /*
         * Initially disable all buttons matching the group.
         */
        for(var j = 0; j < iGrpButtons.length; j += 1) {
            $(iGrpButtons[j]).attr("disabled", "disabled");
        }

        /*
         * Iterate over elements and check for its length.
         * If it is empty show required message,
         * else check for secondary validation.
         * If fails show the respective message and return.  
         */
        for(var i = 0; i < iGrpElmnts.length; i += 1) {
             if(!$(iGrpElmnts[i]).val()) {
                 /*
                  * If required check doesn't succeeds for any 
                  * of the input element in the group show 
                  * respective message and return.
                  */
                 allIsWell = false;
                 /*
                  * Calculate top and left of current element, to set error message.
                  */
                 setMessage($(iGrpElmnts[i]), $(iGrpElmnts[i]).data("req-message"));
                  
                 break;
             } else if($(iGrpElmnts[i]).data("secondary-check")) {
                 /*
                  * If required check succeeds for current 
                  * input element in the group check for its secondary
                  * validation and if fails show 
                  * respective message and return.
                  */
                 var secCheck = $(iGrpElmnts[i]).data("secondary-check");
                 if(!patterns[secCheck].test($(iGrpElmnts[i]).val())) {

                     /*
                      * Calculate top and left of current element, to set error message.
                      */
                     setMessage($(iGrpElmnts[i]), messages[secCheck]);
                     allIsWell = false;
                     break;
                 }
             }
        }

        /*
         * If allIsWell true enable subsmit button matching the group.
         */
        if(allIsWell) {
            for(var k = 0; k < iGrpButtons.length; k += 1) {
                $(iGrpButtons[k]).removeAttr("disabled");
            }
            return;
        }
        return;
    },

    /*
     * Calculate top and left of current element and set message.
     */
    setMessage = function(inputElm, message) {
        var p = $(inputElm).position();
        $("#input-error").html(message);
        $('#error-message-container').show();
        //$(inputElm).after(messageContainer);
        /*$(".formErrorContent").html(message + "<br>");
        $(".reqformError").css({top: p.top, left: p.left + $(inputElm).width() - 15});*/
    },

    /*
     * Disable all buttons which data-disable-on-load is set to true.
     */
    disableSubmitButtonOnPageLoad = function() {
        var buttons = $("input[type=button]");
        for(var i = 0; i < buttons.length; i += 1) {
            if($(buttons[i]).data("disable-on-load") === true) {
                $(buttons[i]).attr("disabled", "disabled");
            }
        }
    }

    $(document).ready(function() {
        /*
         * Initially submit botton will be disabled 
         */
        disableSubmitButtonOnPageLoad();
        $('#error-message-container').hide();
        $(".validate").live('keyup', inputValidator);
        $(".validate").live('blur', inputValidator);
    });

})();

