import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import {DashboardComponent} from './dashboard.component';
import {RicesComponent} from './rices.component';
import {ShopCartComponent} from './shopcart.component';
import {RiceDetailComponent} from './rice-detail.component';

const routes: Routes = [
    {path: '', redirectTo: '/dashboard', pathMatch: 'full'},
    {path: 'dashboard', component: DashboardComponent},
    {path: 'rices', component: RicesComponent},
    {path: 'shopcart', component: ShopCartComponent},
    {path: 'detail/:id', component: RiceDetailComponent}
]
@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
    
export class AppRoutingModule{}
