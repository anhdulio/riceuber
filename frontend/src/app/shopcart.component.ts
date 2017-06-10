import { Component, OnInit } from '@angular/core';
import { ShopCartService } from './shopcart.service';
import { Rice } from './rice';
import { Observable } from 'rxjs';
import {of} from 'rxjs/observable/of';

@Component({
    selector: 'shopcart',
    styleUrls: ['./shopcart.component.css'],
    templateUrl: './shopcart.component.html'
})

export class ShopCartComponent implements OnInit{
    title = 'Shop Cart'
    public shoppingCartItems$: Observable<Rice[]> = of ([]);
    public shoppingCartItems: Rice[] = [];

    constructor(private shopCartService: ShopCartService){
        this.shoppingCartItems$ = this.shopCartService.getItems();

        this.shoppingCartItems$.subscribe(_ => this.shoppingCartItems = _);
    }

    ngOnInit() {
    }

    public getTotal(): Observable<number> {
        return this.shopCartService.getTotalAmount();
    }

    public removeItem(item: Rice) {
        this.shopCartService.removeFromCart(item);
    }
}