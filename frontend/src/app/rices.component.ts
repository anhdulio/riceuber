import { Component, OnInit } from '@angular/core';
import {Rice} from './rice';
import {RiceService} from './rice.service';

@Component({
    selector: 'rices-list',
    templateUrl: './rices.component.html',
    styleUrls: ['./rices.component.css']
})

export class RicesComponent implements OnInit {
    title = 'Rices List';
    rices: Rice[];
    constructor (
        private riceService: RiceService
    ) {}
    getRices(): void {
        this.riceService.getRices().then(rices => this.rices = rices);
    }

    ngOnInit(): void {
        this.getRices();
    }

}