import 'rxjs/add/operator/switchMap';
import { Component, Input, OnInit} from '@angular/core';
import {Rice} from './rice';
import {ActivatedRoute, Params } from '@angular/router';
import {Location} from '@angular/common';
import {RiceService} from './rice.service';
import {ShopCartService} from './shopcart.service';

@Component({
    selector: 'rice-detail',
    templateUrl: './rice-detail.component.html',
    styleUrls: ['./rice-detail.component.css']
})
export class RiceDetailComponent implements OnInit{
    rice: Rice;
    
    constructor(
        private riceService: RiceService,
        private route: ActivatedRoute,
        private location: Location,
        private shopCartService: ShopCartService,
    ){}

    ngOnInit(): void {
        this.route.params.switchMap((params: Params) => this.riceService.getRice(+params['id']))
        .subscribe(rice => this.rice = rice);
    }
    goBack(): void {
        this.location.back();
    }
    //save(): void {
        //this.riceService.update(this.rice)
        //.then(() => this.goBack());
    //}
    public addToCart(item: Rice): void {
        this.shopCartService.addToCart(item);  
    } 
}