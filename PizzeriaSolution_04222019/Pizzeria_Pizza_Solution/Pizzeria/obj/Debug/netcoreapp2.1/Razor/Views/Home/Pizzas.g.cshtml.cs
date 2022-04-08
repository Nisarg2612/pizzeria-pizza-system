#pragma checksum "C:\Users\Rohit\Documents\Visual Studio 2017\Projects\PizzeriaSolution\Pizzeria\Views\Home\Pizzas.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "c467a4d0be09b08b22415c17f5e51c8cc4aacf43"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Home_Pizzas), @"mvc.1.0.view", @"/Views/Home/Pizzas.cshtml")]
[assembly:global::Microsoft.AspNetCore.Mvc.Razor.Compilation.RazorViewAttribute(@"/Views/Home/Pizzas.cshtml", typeof(AspNetCore.Views_Home_Pizzas))]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#line 1 "C:\Users\Rohit\Documents\Visual Studio 2017\Projects\PizzeriaSolution\Pizzeria\Views\_ViewImports.cshtml"
using Pizzeria;

#line default
#line hidden
#line 2 "C:\Users\Rohit\Documents\Visual Studio 2017\Projects\PizzeriaSolution\Pizzeria\Views\_ViewImports.cshtml"
using Pizzeria.Models;

#line default
#line hidden
#line 1 "C:\Users\Rohit\Documents\Visual Studio 2017\Projects\PizzeriaSolution\Pizzeria\Views\Home\Pizzas.cshtml"
using Microsoft.AspNetCore.Identity;

#line default
#line hidden
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"c467a4d0be09b08b22415c17f5e51c8cc4aacf43", @"/Views/Home/Pizzas.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"f29882038f17b918a0c58e0cb2361f7cb5b3eb67", @"/Views/_ViewImports.cshtml")]
    public class Views_Home_Pizzas : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("src", new global::Microsoft.AspNetCore.Html.HtmlString("~/images/pz1.png"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_1 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("alt", new global::Microsoft.AspNetCore.Html.HtmlString(""), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_2 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("class", new global::Microsoft.AspNetCore.Html.HtmlString("img-responsive"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            BeginContext(38, 2, true);
            WriteLiteral("\r\n");
            EndContext();
            BeginContext(138, 2, true);
            WriteLiteral("\r\n");
            EndContext();
#line 6 "C:\Users\Rohit\Documents\Visual Studio 2017\Projects\PizzeriaSolution\Pizzeria\Views\Home\Pizzas.cshtml"
  
    ViewData["Title"] = "Pizzas";

#line default
#line hidden
            BeginContext(182, 3245, true);
            WriteLiteral(@"
<section class=""page-info new-block"">
    <div class=""fixed-bg"" style=""background: url('/images/info-bg.jpg');""></div>
    <div class=""overlay""></div>
    <div class=""container"">
        <h1>Pizzas</h1>
        <h4>pizza makes everything better</h4>
        <div class=""clear-fix""></div>
    </div>
</section>


<section class=""domnoo-menu-filter list-grid-sec new-block"">
    <div class=""overlay""></div>
    <div class=""filters"">

        <div class=""filter-tabnav text-center"">
            <div class=""container"">
                <ul class=""button-group js-radio-button-group"" data-filter-group=""item_cat_inner"">
                    <li class=""sort-btn tab-flr-btn-sort-btn-active"" data-sort=""default:asc""><span>Newest</span></li>
                    <li class=""sort-btn"" data-sort=""popularity:asc""><span>Popular</span></li>
                    <li class=""sort-btn"" data-sort=""price:asc""><span>Low to High</span></li>
                    <li class=""sort-btn"" data-sort=""price:desc""><span>High to Low");
            WriteLiteral(@"</span></li>
                </ul>
                <ul class=""filter-check"">
                    <li>
                        <div class=""form-check"">
                            <label>
                                <input type=""radio"" name=""level""> <span class=""label-text"">Veg</span>
                            </label>
                        </div>
                    </li>
                    <li>
                        <div class=""form-check"">
                            <label>
                                <input type=""radio"" name=""level""> <span class=""label-text"">Non Veg</span>
                            </label>
                        </div>
                    </li>
                    <li>
                        <div class=""form-check"">
                            <label>
                                <input type=""radio"" name=""level""> <span class=""label-text"">Pan</span>
                            </label>
                        </div>
                    </li>
 ");
            WriteLiteral(@"               </ul>
                <div class=""clearfix""></div>
            </div>
        </div>
    </div>

    <div class=""clearfix""></div>



    <div class=""container"">
        <div id=""grid"">
            
        </div>
    </div>



</section>



<section class=""amezing-offers new-block"">
    <div class=""overlay""></div>
    <div class=""fixed-bg parallax"" style=""background: url('/images/bg1.png');""></div>
    <div class=""container-fluid"">
        <div class=""row"">
            <div class=""col-lg-6 col-md-6 col-sm-6"">
                <div class=""text-block-stl1"">
                    <div class=""title"">
                        <p class=""top-h"">amazing offers</p>
                        <h2>50% off pizzas online</h2>
                        <p class=""bottom-p"">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ornare placerat tellus sit amet ullamcorper.</p>
                        <a href=""#"" class=""btn1 stl2"">about more</a>
                    </div>
    ");
            WriteLiteral("            </div>\r\n            </div>\r\n            <div class=\"col-lg-6 col-md-6 col-sm-6\">\r\n                <div class=\"img-holder\" style=\"right:0;\">\r\n                    ");
            EndContext();
            BeginContext(3427, 58, false);
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("img", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagOnly, "254fb64881c94dbcb05c6d29e2c5bd41", async() => {
            }
            );
            __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_0);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_1);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_2);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            EndContext();
            BeginContext(3485, 2020, true);
            WriteLiteral(@"
                </div>
            </div>
        </div>
    </div>
</section>

<script type=""text/javascript"">
    var filterModel = {
        SearchExpression: """",
        SortExpression: """",
        SortDirection: """",
        StartIndex: 1,
        PageSize: 10
    }
    var dataList = [];

    function getDataList() {
        pizzeria.helper.postData(""/Home/GetPizzaList"", filterModel).then(function (data) {
            if (data) {
                var html = """";
                dataList = data[""resultSet""];

                for (var i = 0; i < dataList.length; i++) {
                    var catClass = dataList[i][""categoryId""] == 1 ? ""veg"" : ""non-veg"";
                    var price = parseInt(dataList[i][""price""]);

                    html += '<div class=""col-md-3 col-sm-6 col-xs-12"">' +
                        '    <div class=""pizza-box"">' +
                        '        <div class=""img-holder"">' +
                        '            <img src=""/' + dataList[i][""filePath");
            WriteLiteral(@"""] + '"" class=""img-responsive"" />' +
                        '            <span class=""pizza-cat ' + catClass + '""></span>' +
                        '        </div>' +
                        '        <div class=""text-block"">' +
                        '            <h4>' + dataList[i][""title""] + '</h4>' +
                        '            <h4 class=""price-pizza""><i class=""fa fa-gbp""></i> ' + price.toFixed(2) + '</h4>' +
                        '            <button type=""button"" class=""btn4 add-to-cart"" data-id=""' + dataList[i][""pizzaId""] + '"">Add to Cart</button>' +
                        '        </div>' +
                        '    </div>' +
                        '</div>';
                }

                $(""#grid"").html(html);
            }
        });
    }

    getDataList();

    $(""a[href='"" + window.location.pathname + ""']"").parent(""li"").addClass(""active"");

    $(document).on(""click"", "".add-to-cart"", function () {
        var isSignedIn = '");
            EndContext();
            BeginContext(5506, 30, false);
#line 146 "C:\Users\Rohit\Documents\Visual Studio 2017\Projects\PizzeriaSolution\Pizzeria\Views\Home\Pizzas.cshtml"
                     Write(SignInManager.IsSignedIn(User));

#line default
#line hidden
            EndContext();
            BeginContext(5536, 472, true);
            WriteLiteral(@"';

        if (isSignedIn == ""True"") {
            var pizzaId = $(this).attr(""data-id"");

            pizzeria.helper.getData(""/Home/AddToCart?pizzaId="" + pizzaId, {}).then(function (data) {
                if (data) {
                    alert(data);
                }
            });
        }
        else {
            alert(""Please sign in first."");
            //window.location.href = ""/Identity/Account/Login"";
        }        
    });
</script>");
            EndContext();
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public UserManager<IdentityUser> UserManager { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public SignInManager<IdentityUser> SignInManager { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; }
    }
}
#pragma warning restore 1591