import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

// Imports for loading & configuring the in-memory web api
import { InMemoryWebApiModule } from 'angular-in-memory-web-api';
import { InMemoryDataService }  from './in-memory-data.service';

//import rice
import { RicesComponent } from './rices.component';
import {DashboardComponent} from './dashboard.component';
import {ShopCartComponent} from './shopcart.component';
import {RiceDetailComponent} from './rice-detail.component';
import {RiceSearchComponent} from './rice-search.component';

//import service
import { RiceService } from './rice.service';
import {ShopCartService} from './shopcart.service';

//import angular material
//import {MaterialModule} from '@angular/material';
//import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
//import {ReactiveFormsModule} from '@angular/forms';

//import footer
import {AppFooter} from './footer.component';

import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent,
    RicesComponent,
    DashboardComponent,
    AppFooter,
    ShopCartComponent,
    RiceDetailComponent,
    RiceSearchComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    AppRoutingModule,
    InMemoryWebApiModule.forRoot(InMemoryDataService),
    //MaterialModule,
    //BrowserAnimationsModule,
  ],
  providers: [RiceService, ShopCartService],
  bootstrap: [AppComponent]
})
export class AppModule { }
