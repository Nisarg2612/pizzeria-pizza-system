#pragma checksum "C:\Users\Rohit\Documents\Visual Studio 2017\Projects\PizzeriaSolution\Pizzeria\Views\Admin\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "48f22ba83794bec91d1af14b76f730869e7b8bfe"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Admin_Index), @"mvc.1.0.view", @"/Views/Admin/Index.cshtml")]
[assembly:global::Microsoft.AspNetCore.Mvc.Razor.Compilation.RazorViewAttribute(@"/Views/Admin/Index.cshtml", typeof(AspNetCore.Views_Admin_Index))]
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
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"48f22ba83794bec91d1af14b76f730869e7b8bfe", @"/Views/Admin/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"f29882038f17b918a0c58e0cb2361f7cb5b3eb67", @"/Views/_ViewImports.cshtml")]
    public class Views_Admin_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            BeginContext(0, 2, true);
            WriteLiteral("\r\n");
            EndContext();
#line 2 "C:\Users\Rohit\Documents\Visual Studio 2017\Projects\PizzeriaSolution\Pizzeria\Views\Admin\Index.cshtml"
  
    ViewData["Title"] = "Dashboard";
    Layout = "~/Views/Shared/_AdminLayout.cshtml";

#line default
#line hidden
            BeginContext(99, 1842, true);
            WriteLiteral(@"
<section class=""content-header"">
    <h1>Dashboard</h1>
</section>

<section class=""content"">
    <!--    STATISTICS      -->
    <div class=""row"">
        <div class=""col-md-4 col-sm-6 col-xs-12"">
            <div class=""info-box"">
                <span class=""info-box-icon bg-red""><i class=""fa fa-truck""></i></span>

                <div class=""info-box-content"">
                    <span class=""info-box-text"">Pizzas</span>
                    <span class=""info-box-number"">90<small>%</small></span>
                </div>
            </div>
        </div>

        <div class=""col-md-4 col-sm-6 col-xs-12"">
            <div class=""info-box"">
                <span class=""info-box-icon bg-green""><i class=""fa fa-truck""></i></span>

                <div class=""info-box-content"">
                    <span class=""info-box-text"">Orders</span>
                    <span class=""info-box-number"">41,410</span>
                </div>
            </div>
        </div>

        <div class=""clear");
            WriteLiteral(@"fix visible-sm-block""></div>

        <div class=""col-md-4 col-sm-6 col-xs-12"">
            <div class=""info-box"">
                <span class=""info-box-icon bg-aqua""><i class=""fa fa-users""></i></span>

                <div class=""info-box-content"">
                    <span class=""info-box-text"">Users</span>
                    <span class=""info-box-number"">760</span>
                </div>
            </div>
        </div>
    </div>


    <!--    NEW ORDERS      -->
    <div class=""row"">
        <div class=""col-md-12"">
            <div class=""box"">
                <div class=""box-header with-border"">
                    <h3 class=""box-title"">New Orders</h3>
                </div>
                <div class=""box-body""></div>
            </div>
        </div>
    </div>
</section>");
            EndContext();
        }
        #pragma warning restore 1998
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
