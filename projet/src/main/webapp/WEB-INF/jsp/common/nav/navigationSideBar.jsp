<%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
    <%@page import="java.util.ArrayList, app.code.model.user.*" %>
        <div class="loader-bg">
            <div class="loader-track">
                <div class="loader-fill"></div>
            </div>
        </div>
        <!-- [ Pre-loader ] End -->
        <!-- [ navigation menu ] start -->
        <nav class="pcoded-navbar">
            <div class="navbar-wrapper">
                <div class="navbar-content scroll-div">
                    <ul class="nav pcoded-inner-navbar">
                        <% if(request.getSession().getAttribute("admin")!=null){ %>
                            <li class="nav-item pcoded-menu-caption">
                                <label>Laptop</label>
                            </li>
                            <h:NavLink text="Liste des references de Laptop" href="/admin/laptops"
                                icon="feather icon-file-text" />
                            <h:NavLink text="Ajouter une reference Laptop" href="/admin/laptop"
                                icon="feather icon-box" />
                            <h:NavLink text="Faire un achat" href="/admin/stock" icon="feather icon-box" />
                            <h:NavLink text="Voir le stock central" href="/admin/stocks" icon="feather icon-box" />
                            <h:NavLink text="Transferer des laptops" href="/admin/stock/transferer"
                                icon="feather icon-box" />
                            <h:NavLink text="Reception de laptop" href="/admin/stock/receipt" icon="feather icon-box" />


                            <li class="nav-item pcoded-menu-caption">
                                <label>Point de vente et utilisateur</label>
                            </li>
                            <h:NavLink text="Liste des point de vente" href="/admin/stores"
                                icon="feather icon-file-text" />
                            <h:NavLink text="Ajouter un point de vente" href="/admin/store" icon="feather icon-box" />
                            <h:NavLink text="Ajouter un utilisateur" href="/admin/store/user" icon="feather icon-box" />

                            <li class="nav-item pcoded-menu-caption">
                                <label>Util</label>
                            </li>
                            <h:NavLink text="Gestion marque" href="/admin/brands" icon="feather icon-file-text" />
                            <h:NavLink text="Gestion des processeur" href="/admin/processors" icon="feather icon-box" />
                            <h:NavLink text="Gestion des ecrans" href="/admin/screens" icon="feather icon-box" />

                            <li class="nav-item pcoded-menu-caption">
                                <label>Statistiques</label>
                                <h:NavLink text="Vente par mois" href="/admin/stat-vente-mois"
                                    icon="feather icon-box" />
                                <h:NavLink text="Vente par mois magasin" href="/admin/stat-vente-mois-magasin"
                                    icon="feather icon-box" />
                                <h:NavLink text="Benefice par mois" href="/admin/stat-benefice"
                                    icon="feather icon-box" />
                                    
                                <h:NavLink text="Commission par mois, par magasin" href="/admin/stat-commission"
                                icon="feather icon-box" />
                            </li>
                            <li class="nav-item pcoded-menu-caption">
                                <label>Settings</label>
                                <h:NavLink text="Gerer les commissions" href="/admin/commission/update"
                                    icon="feather icon-box" />
                            </li>


                            <% } %>
                                <% if(request.getSession().getAttribute("store")!=null){ %>
                                    <li class="nav-item pcoded-menu-caption">
                                        <label>Gestion de reception</label>
                                    </li>
                                    <h:NavLink text="Reception de laptop" href="/store/receipt"
                                        icon="feather icon-file-text" />
                                    <h:NavLink text="Renvoie de Laptop" href="/store/send-back"
                                        icon="feather icon-box" />

                                    <li class="nav-item pcoded-menu-caption">
                                        <label>Vente</label>
                                    </li>
                                    <h:NavLink text="Ajouter une vente" href="/store/sale"
                                        icon="feather icon-file-text" />
                                    <h:NavLink text="Voir les ventes" href="/store/sales" icon="feather icon-box" />

                                    <li class="nav-item pcoded-menu-caption">
                                        <label>Stock</label>
                                    </li>
                                    <h:NavLink text="Voir le stock" href="/store/stocks" icon="feather icon-box" />

                                    <% } %>
                                    <li class="nav-item pcoded-menu-caption">
                                        <label>Reference template</label>
                                    </li>
                                    <h:NavLink text="FLATABLE" href="https://themewagon.github.io/flat_able/?_ga=2.103972288.1119738050.1684440755-523477605.1684440755" icon="feather icon-box" />
                    </ul>
                </div>
            </div>
        </nav>
