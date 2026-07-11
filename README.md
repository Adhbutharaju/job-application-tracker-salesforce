# 🏢 Job Application Tracker — Salesforce CRM Project

A production-quality Salesforce application built to manage 
job applications, interviews, and hiring pipelines end-to-end.

## 📋 Project Overview

This project demonstrates real-world Salesforce development 
skills including custom data modeling, Apex automation, 
Lightning Web Components, and declarative tools.

## 🏗️ Architecture

### Data Model
- **Company__c** — Stores company information
- **Job__c** — Job postings linked to companies  
- **Application__c** — Core object tracking each application
- **Interview__c** — Interview rounds (Master-Detail to Application)

### Relationships
Company__c (1)
└── Job__c (Many)
└── Application__c (Many)
└── Interview__c (Many - Master Detail)

## ⚡ Features Built

### Phase 1 — Data Model
- 4 Custom Objects with relationships
- Roll-Up Summary field (Interview Count)
- Custom Lightning App with navigation

### Phase 2 — Automation
- **Record-Triggered Flow** — Email alert + Task when interview scheduled
- **Apex Trigger + Handler Pattern** — Auto-updates Application 
  status based on Interview outcome
- **Batch Apex + Scheduler** — Nightly job to auto-close 
  stale applications

### Phase 3 — Lightning Web Components
- **Application Kanban Board** — Visual pipeline by status
- **Quick Action Form** — Modal form with toast notifications
- **Interview Stats Chart** — Pass/fail rates and visual charts

### Phase 4 — Testing
- 13 Apex test methods across 4 test classes
- TestDataFactory pattern for reusable test data
- 88%+ average code coverage

### Phase 5 — Deployment
- Reports & Dashboards — 4 reports + 1 dashboard
- SFDX deployment using Salesforce CLI
- Full metadata package with package.xml

## 🛠️ Technologies Used

| Technology | Usage |
|---|---|
| Salesforce Apex | Triggers, Batch, Controllers |
| Lightning Web Components | UI Components |
| Flow Builder | Automation |
| SOQL | Data queries |
| Salesforce CLI | Deployment |
| Git/GitHub | Version control |

## 📊 Key Concepts Demonstrated

### Apex
- ✅ Trigger Handler Pattern
- ✅ Bulkification — Set, Map, List
- ✅ Governor Limits awareness
- ✅ Aggregate SOQL + AggregateResult
- ✅ Wrapper Class pattern
- ✅ Batch Apex — start, execute, finish
- ✅ Schedulable Interface + Cron expressions
- ✅ Database.QueryLocator
- ✅ Test Data Factory Pattern
- ✅ System.assertEquals assertions

### LWC
- ✅ @wire, @api, @track decorators
- ✅ Imperative Apex calls
- ✅ for:each and if:true directives
- ✅ lightning-record-edit-form
- ✅ ShowToastEvent notifications
- ✅ NavigationMixin
- ✅ Getter methods for computed values
- ✅ Dynamic inline styles

### Declarative
- ✅ Record-Triggered Flows
- ✅ Email Templates + Email Alerts
- ✅ Recipient Types — Owner, Related User
- ✅ Roll-Up Summary fields
- ✅ Reports — Summary, Matrix formats
- ✅ Dashboards with multiple chart types

---

## 📁 Project Structure
force-app/main/default/
├── classes/
│   ├── ApplicationKanbanController.cls
│   ├── InterviewStatsController.cls
│   ├── InterviewTriggerHandler.cls
│   ├── StaleApplicationBatch.cls
│   ├── TestDataFactory.cls
│   ├── ApplicationKanbanControllerTest.cls
│   ├── InterviewStatsControllerTest.cls
│   ├── InterviewTriggerHandlerTest.cls
│   └── StaleApplicationBatchTest.cls
├── triggers/
│   └── InterviewTrigger.trigger
├── lwc/
│   ├── applicationKanban/
│   ├── applicationForm/
│   └── interviewStats/
├── objects/
│   ├── Application__c/
│   ├── Company__c/
│   ├── Interview__c/
│   └── Job__c/
└── flows/
└── RT_Interview_Scheduled_Alert.flow-meta.xml

---

## 🚀 Deployment Instructions

### Prerequisites
- Salesforce CLI installed
- VS Code with Salesforce Extension Pack installed
- Developer Edition org authorized

### Steps

```bash
# Clone repository
git clone https://github.com/Adhbutharaju/job-application-tracker-salesforce.git

# Navigate to project
cd job-application-tracker-salesforce

# Authorize your org
sf org login web --alias MyOrg

# Deploy to org
sf project deploy start --manifest manifest/package.xml --target-org MyOrg
```

---

## 📸 Screenshots

### 🖥️ Kanban Board
> Add screenshot here

### 📊 Dashboard
> Add screenshot here

### 📈 Interview Stats
> Add screenshot here

---

## 🎯 What I Learned

Building this project taught me:
- How to design a complete Salesforce data model from scratch
- Industry-standard Trigger Handler pattern
- Bulkification and Governor Limits in real scenarios
- Building interactive LWC components with real data
- Professional email automation using Templates and Alerts
- Batch processing for large data operations
- Writing proper test classes with high coverage
- Deploying Salesforce projects using CLI

---

## 👨‍💻 Author

**Raju Chintha**
Salesforce Developer

[![GitHub](https://img.shields.io/badge/GitHub-Adhbutharaju-blue)](https://github.com/Adhbutharaju)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).