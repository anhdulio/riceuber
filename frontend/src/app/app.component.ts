// src/app/app.component.ts
 
import { Component } from '@angular/core';
import { Http } from '@angular/http';
import { BASE_IP } from './constants'

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app works!';
  books;
 
  constructor(private http: Http) {
  	console.log(BASE_IP)
  	var requestAddress = BASE_IP + ':3000/books.json';
  	console.log(requestAddress);
    http.get(requestAddress)
      .subscribe(res => this.books = res.json());
  }
}