import { Injectable } from '@angular/core';
import 'rxjs/add/operator/toPromise';
import {Http, Headers} from '@angular/http'; 
import {Rice} from './rice'

@Injectable()
export class RiceService {

    getRice(id: number): Promise<Rice> {
        const url = `${this.ricesUrl}/${id}`;
        return this.http.get(url)
            .toPromise()
            .then(response => response.json().data as Rice)
            .catch(this.handleError);
    }

    private ricesUrl = 'api/rices';
    constructor (private http: Http) {};
    getRices(): Promise<Rice[]> {
        return this.http.get(this.ricesUrl)
        .toPromise()
        .then(response => response.json().data as Rice[])
        .catch(this.handleError);
    }
    private handleError(error: any): Promise<any> {
        console.error('An error occurred', error); // for demo purposes only
        return Promise.reject(error.message || error);
    }
}