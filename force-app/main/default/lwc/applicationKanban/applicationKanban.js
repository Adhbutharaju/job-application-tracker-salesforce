import { LightningElement, track, wire } from 'lwc';
import getApplications from '@salesforce/apex/ApplicationKanbanController.getApplications';

export default class ApplicationKanban extends LightningElement {

    @track applications = [];
    @track isLoading = true;
    @track errorMessage = '';

    // @wire automatically calls Apex and stores result
    @wire(getApplications)
    wiredApplications({ data, error }) {
        if (data) {
            this.applications = data;
            this.isLoading = false;
        } else if (error) {
            this.errorMessage = error.body.message;
            this.isLoading = false;
        }
    }

    // getter — filters Applied applications
    get appliedList() {
        return this.applications.filter(app => app.Status__c === 'Applied');
    }

    // getter — filters Interview applications
    get interviewList() {
        return this.applications.filter(app => app.Status__c === 'Interview');
    }

    // getter — filters Next Round applications
    get nextRoundList() {
        return this.applications.filter(app => app.Status__c === 'Next Round');
    }

    // getter — filters Offer Received applications
    get offerList() {
        return this.applications.filter(app => app.Status__c === 'Offer Received');
    }

    // getter — filters Rejected applications
    get rejectedList() {
        return this.applications.filter(app => app.Status__c === 'Rejected');
    }

    // getter — checks if any applications exist
    get hasApplications() {
        return this.applications.length > 0;
    }
}