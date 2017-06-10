import {Injectable} from '@angular/core';
import {Rice} from './rice';
import {BehaviorSubject, Observable, Subject, Subscriber} from 'rxjs';
import {of} from 'rxjs/observable/of';

@Injectable()
export class ShopCartService {
    private itemInCartSubject: BehaviorSubject<Rice[]> = new BehaviorSubject([]);
    private itemInCart: Rice[] = [];

    constructor() {
        this.itemInCartSubject.subscribe(_=> this.itemInCart = _);
    }

    public addToCart(item: Rice) {
        this.itemInCartSubject.next([...this.itemInCart, item]);
    }

    public removeFromCart(item: Rice){
        const currentItems = [...this.itemInCart];
        const itemsWithoutRemoved = currentItems.filter(_=> _.id !== item.id);
        this.itemInCartSubject.next(itemsWithoutRemoved);
    }

    public getItems(): Observable<Rice[]> {
        return this.itemInCartSubject.asObservable();
    }

    public getTotalAmount(): Observable<number> {
        return this.itemInCartSubject.map((items: Rice[]) => {
            return items.reduce((prev, curr: Rice) => {
                return prev + curr.price;
            }, 0);
        })
    }
}