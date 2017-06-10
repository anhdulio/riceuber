import { Component, OnInit } from '@angular/core';
import {Rice} from './rice';
import {RiceService} from './rice.service';
import {ShopCartService} from './shopcart.service';

@Component({
    selector: 'dashboard',
    templateUrl: './dashboard.component.html',
    styleUrls: ['./dashboard.component.css']
})

export class DashboardComponent implements OnInit {
    rices: Rice[] = [];
    constructor(private riceService: RiceService, 
    private shopCartService: ShopCartService) {};

    ngOnInit(): void {
        this.riceService.getRices()
        .then(rices => this.rices = rices.slice(0,5));
    };

    public addToCart(item: Rice): void {
        this.shopCartService.addToCart(item);
        
    } 
}