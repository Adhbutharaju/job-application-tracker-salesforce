import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class ApplicationForm extends NavigationMixin(LightningElement) {

    @track isModalOpen = false;

    // Opens the modal
    openModal() {
        this.isModalOpen = true;
    }

    // Closes the modal
    closeModal() {
        this.isModalOpen = false;
    }

    // Runs when form saves successfully
    handleSuccess(event) {
        const recordId = event.detail.id;

        // Close the modal
        this.isModalOpen = false;

        // Show success toast notification
        this.dispatchEvent(
            new ShowToastEvent({
                title: '✅ Application Saved!',
                message: 'Your job application has been created successfully.',
                variant: 'success'
            })
        );

        // Navigate to the new Application record
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view'
            }
        });
    }

    // Runs when form has an error
    handleError(event) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: '❌ Error!',
                message: event.detail.message,
                variant: 'error'
            })
        );
    }
}