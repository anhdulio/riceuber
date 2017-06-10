import { Injectable } from '@angular/core';
import { Http }       from '@angular/http';
import { Observable }     from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import { Rice }           from './rice';
@Injectable()
export class RiceSearchService {
  constructor(private http: Http) {}
  search(term: string): Observable<Rice[]> {
    return this.http
               .get(`app/rices/?name=${term}`)
               .map(response => response.json().data as Rice[]);
  }
}
