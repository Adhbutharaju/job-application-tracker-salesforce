import { LightningElement, track, wire } from 'lwc';
import getApplicationStats from '@salesforce/apex/InterviewStatsController.getApplicationStats';
import getSummaryStats from '@salesforce/apex/InterviewStatsController.getSummaryStats';

export default class InterviewStats extends LightningElement {

    @track appStats = [];
    @track totalApplications = 0;
    @track totalInterviews = 0;
    @track passed = 0;
    @track failed = 0;
    @track isLoading = true;

    // fetch application stats grouped by status
    @wire(getApplicationStats)
    wiredAppStats({ data, error }) {
        if (data) {
            // find max count for bar width calculation
            let maxCount = Math.max(...data.map(s => s.appCount), 1);

            // add barStyle to each stat for dynamic bar width
            this.appStats = data.map(stat => ({
                ...stat,
                barStyle: `width: ${Math.round((stat.appCount / maxCount) * 100)}%`
            }));
            this.isLoading = false;
        }
    }

    // fetch summary stats
    @wire(getSummaryStats)
    wiredSummary({ data, error }) {
        if (data) {
            this.totalApplications = data.totalApplications;
            this.totalInterviews   = data.totalInterviews;
            this.passed            = data.passed;
            this.failed            = data.failed;
            this.isLoading         = false;
        }
    }

    // Pass rate percentage
    get passRate() {
        if (this.totalInterviews === 0) return 0;
        return Math.round((this.passed / this.totalInterviews) * 100);
    }

    // Fail rate percentage
    get failRate() {
        if (this.totalInterviews === 0) return 0;
        return Math.round((this.failed / this.totalInterviews) * 100);
    }

    // Bar width style for passed interviews
    get passBarStyle() {
        return `width: ${this.passRate}%`;
    }

    // Bar width style for failed interviews
    get failBarStyle() {
        return `width: ${this.failRate}%`;
    }
}