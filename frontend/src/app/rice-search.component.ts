import { Component, OnInit, ElementRef } from '@angular/core';
import { Router }            from '@angular/router';
import { Observable }        from 'rxjs/Observable';
import { Subject }           from 'rxjs/Subject';
// Observable class extensions
import 'rxjs/add/observable/of';
// Observable operators
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/debounceTime';
import 'rxjs/add/operator/distinctUntilChanged';
import { RiceSearchService } from './rice-search.service';
import { Rice } from './rice';

// Observable class extensions
import 'rxjs/add/observable/of';

// Observable operators
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/debounceTime';
import 'rxjs/add/operator/distinctUntilChanged';

@Component({
  selector: 'rice-search',
  templateUrl: './rice-search.component.html',
  styleUrls: [ './rice-search.component.css' ],
  providers: [RiceSearchService],
  host: { '(document:click)': 'handleClick($event)', },
})
export class RiceSearchComponent implements OnInit {
  rices: Observable<Rice []>;
  private searchTerms = new Subject<string>();
  private elementRef;
  private filteredList = [];

  constructor(
    private riceSearchService: RiceSearchService,
    private router: Router,
    private myElement: ElementRef) {this.elementRef = myElement;};
  // Push a search term into the observable stream.
  search(term: string): void {
    this.searchTerms.next(term);
  }

  ngOnInit(): void {
    this.rices = this.searchTerms
      .debounceTime(300)        // wait 300ms after each keystroke before considering the term
      .distinctUntilChanged()   // ignore if next search term is same as previous
      .switchMap(term => term   // switch to new observable each time the term changes
        // return the http search observable
        ? this.riceSearchService.search(term)
        // or the observable of empty heroes if there was no search term
        : Observable.of<Rice[]>([]))
      .catch(error => {
        // TODO: add real error handling
        console.log(error);
        return Observable.of<Rice[]>([]);
      });
  }

  gotoDetail(rice: Rice): void {
    let link = ['/detail', rice.id];
    this.router.navigate(link);
    this.search('');
  }

  handleClick(event){
   var clickedComponent = event.target;
   var inside = false;
   do {
       if (clickedComponent === this.elementRef.nativeElement) {
           inside = true;
       }
      clickedComponent = clickedComponent.parentNode;
   } while (clickedComponent);
    if(!inside){
        this.search('');
    }
}

}
