{
  "branding": {
    "delimiter": ",",
    "browser_title": "Portland Executive Insights",
    "title": "Portland Executive Insights"
  },
  "date_options": {
    "type": "yearly",
    "default_year": "2020",
    "year_start_month": "7"
  },
  "tag_list": [
    "Financials",
    "Budget & Expenditures",
    "Payroll & HR",
    "Revenue & Tax",
    "Schools"
  ],
  "show_share_via_email": true,
  "is_private": "false",
  "template_entries": [
    {
      "name": "Core Financials",
      "dataset_domain": "portlandme.data.socrata.com",
      "dataset_id": "b5z7-aw6y",
      "fields": {
        "date_column": "fiscalmonth"
      },
      "dimension_entries": [
        {
          "column": "segment2",
          "name": "Function"
        },
        {
          "column": "segment3",
          "name": "Department"
        },
        {
          "column": "fund",
          "name": "Fund"
        },
        {
          "column": "segment4",
          "name": "Division"
        },
        {
          "column": "organization",
          "name": "Organisation"
        },
        {
          "column": "object",
          "name": "Budget Object"
        },
        {
          "column": "charactercodedescription",
          "name": "Character Code"
        },
        {
          "column": "accountdescription",
          "name": "Account Description"
        }
      ],
      "view_entries": [
        {
          "name": "Cash Balance",
          "parent_queries": [
            "select * where cashaccount = 'true'"
          ],
          "column": "actual",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Financials"
          ],
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": ">",
              "value": "135000000",
              "icon": "icons-check-circle",
              "target_entry_description": "Cash balance is currently on target against an FY20 plan of $135 million."
            },
            {
              "name": "Off track",
              "color": "#e31219",
              "icon": "icons-times-circle"
            }
          ],
          "quick_filters": [],
          "visualization": {
            "default_view": "overtime",
            "overtime": {
              "show_area_chart": "false",
              "show_burn_up_chart": "true",
              "default_view": "burn_up"
            }
          },
          "start_date_override_and_ignore": "true"
        },
        {
          "name": "General Fund Cash Balance",
          "parent_queries": [
            "select * where cashaccount = 'true' and fund = 'General Fund'"
          ],
          "column": "actual",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Financials"
          ],
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": ">",
              "value": "0",
              "icon": "icons-check-circle"
            },
            {
              "name": "Off track",
              "color": "#e31219",
              "icon": "icons-times-circle"
            }
          ],
          "quick_filters": [],
          "visualization": {
            "default_view": "overtime",
            "overtime": {
              "show_area_chart": "false",
              "show_burn_up_chart": "true",
              "default_view": "burn_up"
            }
          },
          "start_date_override_and_ignore": "true"
        },
        {
          "name": "Unadjusted Net Income",
          "parent_queries": [
            "select *, case(accounttype == 'Revenue', actual, true, 0) as revenue_amount, case(accounttype == 'Expense', actual, true, 0) as expenditures_amount"
          ],
          "column": "sum(revenue_amount) - sum(expenditures_amount)",
          "aggregate_type": "",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Financials"
          ],
          "target_entries": [],
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revenue_amount",
                    "name": "Revenue Amount",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "expenditures_amount",
                    "name": "Expenditure Amount",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ]
              }
            },
            "overtime": {
              "show_area_chart": "false",
              "show_burn_up_chart": "true",
              "timeline": {
                "secondary_metric_entries": [
                  {
                    "column": "revenue_amount",
                    "name": "Revenue Amount",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "expenditures_amount",
                    "name": "Expenditure Amount",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ]
              }
            }
          }
        }
      ],
      "leaf_page_entries": [
        {
          "column": "segment2",
          "name": "Function"
        },
        {
          "column": "segment3",
          "name": "Department"
        },
        {
          "column": "fund",
          "name": "Fund"
        },
        {
          "column": "segment4",
          "name": "Division"
        },
        {
          "column": "organization",
          "name": "Organisation"
        },
        {
          "column": "object",
          "name": "Budget Object"
        },
        {
          "column": "charactercodedescription",
          "name": "Character Code"
        },
        {
          "column": "accountdescription",
          "name": "Account Description"
        }
      ],
      "quick_filter_entries": [
        {
          "column": "accounttype",
          "name": "Account Type",
          "renderType": "text"
        },
        {
          "column": "fund",
          "name": "Fund",
          "renderType": "text"
        },
        {
          "column": "actual",
          "name": "Actual Spending",
          "renderType": "number"
        }
      ]
    },
    {
      "name": "Budget Expenses",
      "dataset_domain": "portlandme.data.socrata.com",
      "dataset_id": "b5z7-aw6y",
      "fields": {
        "date_column": "fiscalmonth"
      },
      "dimension_entries": [
        {
          "column": "segment2",
          "name": "Function"
        },
        {
          "column": "segment3",
          "name": "Department"
        },
        {
          "column": "fund",
          "name": "Fund"
        },
        {
          "column": "segment4",
          "name": "Division"
        },
        {
          "column": "organization",
          "name": "Organisation"
        },
        {
          "column": "object",
          "name": "Budget Object"
        },
        {
          "column": "charactercodedescription",
          "name": "Character Code"
        },
        {
          "column": "accountdescription",
          "name": "Account Description"
        }
      ],
      "view_entries": [
        {
          "name": "Actuals vs. Budget",
          "primary_metric_name": "Actuals",
          "column": "actual",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Budget & Expenditures"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ],
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              },
              "burn_up": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          },
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": ">",
              "value": "1000",
              "icon": "icons-check-circle",
              "target_entry_description": "Spending is currently on track to remain within budgeted levels ($332 million for FY20)."
            },
            {
              "name": "Off track",
              "color": "#e31219",
              "icon": "icons-times-circle"
            }
          ]
        },
        {
          "name": "City Actuals vs. Budget",
          "primary_metric_name": "Actuals",
          "column": "actual",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Budget & Expenditures"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ],
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              },
              "burn_up": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          },
          "parent_queries": [
            "select * where entity = 'City'"
          ],
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": ">",
              "value": "1000",
              "icon": "icons-check-circle",
              "target_entry_description": "Spending is currently on track to remain within budgeted levels ($332 million for FY20)."
            },
            {
              "name": "Off track",
              "color": "#e31219",
              "icon": "icons-times-circle"
            }
          ]
        },
        {
          "name": "Schools Actuals vs. Budget",
          "column": "actual",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Budget & Expenditures",
            "Schools"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ],
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              },
              "burn_up": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          },
          "parent_queries": [
            "select * where entity = 'School'"
          ],
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": "<",
              "value": "1000",
              "icon": "icons-check-circle"
            }
          ]
        },
        {
          "name": "Payroll Expenses vs. Budget",
          "column": "actual",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Budget & Expenditures",
            "Payroll & HR"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ],
                "default_secondary_metric": "Revised Budget"
              },
              "default_comparison_column_entry": "revisedbudget"
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              },
              "burn_up": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          },
          "parent_queries": [
            "select * where charactercodedescription = 'Payroll'"
          ]
        }
      ],
      "leaf_page_entries": [
        {
          "column": "segment2",
          "name": "Function"
        },
        {
          "column": "segment3",
          "name": "Department"
        },
        {
          "column": "fund",
          "name": "Fund"
        },
        {
          "column": "segment4",
          "name": "Division"
        },
        {
          "column": "organization",
          "name": "Organisation"
        },
        {
          "column": "object",
          "name": "Budget Object"
        },
        {
          "column": "charactercodedescription",
          "name": "Character Code"
        },
        {
          "column": "accountdescription",
          "name": "Account Description"
        }
      ],
      "quick_filter_entries": [
        {
          "column": "accounttype",
          "name": "Account Type",
          "renderType": "text"
        }
      ]
    },
    {
      "name": "Expense Details",
      "dataset_domain": "portlandme.data.socrata.com",
      "dataset_id": "drvx-98uq",
      "fields": {
        "date_column": "date"
      },
      "parent_queries": [
        "select * where accounttype = 'Expense' and accountstatus = 'Active'"
      ],
      "dimension_entries": [
        {
          "column": "segment2",
          "name": "Function"
        },
        {
          "column": "segment3",
          "name": "Department"
        },
        {
          "column": "fund",
          "name": "Fund"
        },
        {
          "column": "segment4",
          "name": "Division"
        },
        {
          "column": "organization",
          "name": "Organisation"
        },
        {
          "column": "object",
          "name": "Budget Object"
        },
        {
          "column": "charactercodedescription",
          "name": "Character Code"
        },
        {
          "column": "vendorname",
          "name": "Vendor"
        }
      ],
      "view_entries": [
        {
          "name": "Average Invoice Days Open",
          "primary_metric_name": "Days",
          "column": "daysopen",
          "aggregate_type": "avg",
          "prefix": "",
          "suffix": "%",
          "precision": "0",
          "tags": [
            "Budget & Expenditures"
          ],
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "area",
              "show_area_chart": "true",
              "show_burn_up_chart": "false",
              "show_timeline_total": "true",
              "timeline": {
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019"
              }
            }
          },
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": ">",
              "value": "1000",
              "icon": "icons-check-circle",
              "target_entry_description": "Spending is currently on track to remain within budgeted levels ($332 million for FY20)."
            },
            {
              "name": "Off track",
              "color": "#e31219",
              "icon": "icons-times-circle"
            }
          ]
        },
        {
          "name": "Percentage of Invoices Paid within 30 Days",
          "primary_metric_name": "Days",
          "column": "(sum(case(daysopen <= 30, 1, true, 0))/count(daysopen))*100",
          "aggregate_type": "",
          "prefix": "",
          "suffix": "",
          "precision": "0",
          "tags": [
            "Budget & Expenditures"
          ],
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "area",
              "show_area_chart": "true",
              "show_burn_up_chart": "false",
              "show_timeline_total": "true",
              "timeline": {
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019"
              }
            }
          },
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": ">",
              "value": "1000",
              "icon": "icons-check-circle",
              "target_entry_description": "Spending is currently on track to remain within budgeted levels ($332 million for FY20)."
            },
            {
              "name": "Off track",
              "color": "#e31219",
              "icon": "icons-times-circle"
            }
          ]
        },
        {
          "name": "Retirement Payouts",
          "primary_metric_name": "Actuals",
          "column": "actual",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Budget & Expenditures"
          ],
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ]
              }
            },
            "overtime": {
              "default_view": "timeline",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ]
              },
              "burn_up": {
                "default_time_frame": "rolling",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ]
              }
            }
          },
          "parent_queries": [
            "select * where object like '%Retire%'"
          ],
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": ">",
              "value": "1000",
              "icon": "icons-check-circle",
              "target_entry_description": "Spending is currently on track to remain within budgeted levels ($332 million for FY20)."
            },
            {
              "name": "Off track",
              "color": "#e31219",
              "icon": "icons-times-circle"
            }
          ]
        },
        {
          "name": "External Vendor Payments",
          "column": "actual",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Budget & Expenditures"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {}
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "secondary_metric_entries": [
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ]
              },
              "burn_up": {
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019"
              }
            }
          },
          "parent_queries": [
            "select * where employee = 'false' and vendorname != 'NULL'"
          ],
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": "<",
              "value": "1000",
              "icon": "icons-check-circle"
            }
          ]
        }
      ],
      "leaf_page_entries": [
        {
          "column": "segment2",
          "name": "Function"
        },
        {
          "column": "segment3",
          "name": "Department"
        },
        {
          "column": "fund",
          "name": "Fund"
        },
        {
          "column": "segment4",
          "name": "Division"
        },
        {
          "column": "organization",
          "name": "Organisation"
        },
        {
          "column": "object",
          "name": "Budget Object"
        },
        {
          "column": "charactercodedescription",
          "name": "Character Code"
        },
        {
          "column": "accountdescription",
          "name": "Account Description"
        }
      ],
      "quick_filter_entries": [
        {
          "column": "accounttype",
          "name": "Account Type",
          "renderType": "text"
        }
      ]
    },
    {
      "name": "Budgeted Revenues",
      "dataset_domain": "portlandme.data.socrata.com",
      "dataset_id": "8mx7-tp5t",
      "fields": {
        "date_column": "fiscalmonth"
      },
      "dimension_entries": [
        {
          "column": "segment2",
          "name": "Function"
        },
        {
          "column": "segment3",
          "name": "Department"
        },
        {
          "column": "fund",
          "name": "Fund"
        },
        {
          "column": "segment4",
          "name": "Division"
        },
        {
          "column": "organization",
          "name": "Organisation"
        },
        {
          "column": "object",
          "name": "Budget Object"
        },
        {
          "column": "charactercodedescription",
          "name": "Character Code"
        },
        {
          "column": "accountdescription",
          "name": "Account Description"
        }
      ],
      "view_entries": [
        {
          "name": "Revenue vs. Budget",
          "column": "actual",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Revenue & Tax"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ],
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              },
              "burn_up": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actuals",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          }
        },
        {
          "name": "Tax Revenue vs. Budget",
          "column": "actual",
          "parent_queries": [
            "select * where charactercodedescription = 'Prop & Excise Taxes'"
          ],
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Revenue & Tax"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ],
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ]
              },
              "burn_up": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          }
        },
        {
          "name": "School Revenues vs. Budget",
          "column": "actual",
          "parent_queries": [
            "select * where entity = 'School'"
          ],
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Revenue & Tax",
            "Schools"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ],
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ]
              },
              "burn_up": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          },
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": ">",
              "value": "1000",
              "icon": "icons-check-circle",
              "target_entry_description": "Water Resources revenues are currently on track to exceed plan (projected $62.5 million against a $54.3m target)."
            },
            {
              "name": "Off track",
              "color": "#e31219",
              "icon": "icons-times-circle"
            }
          ]
        },
        {
          "name": "City Revenues vs. Budget",
          "column": "actual",
          "parent_queries": [
            "select * where entity = 'City'"
          ],
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Revenue & Tax",
            "Water Resources"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ],
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ]
              },
              "burn_up": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          },
          "target_entries": [
            {
              "name": "On track",
              "color": "#259652",
              "operator": ">",
              "value": "1000",
              "icon": "icons-check-circle",
              "target_entry_description": "Water Resources revenues are currently on track to exceed plan (projected $62.5 million against a $54.3m target)."
            },
            {
              "name": "Off track",
              "color": "#e31219",
              "icon": "icons-times-circle"
            }
          ]
        },
        {
          "name": "Jetport Revenues vs. Budget",
          "column": "actual",
          "parent_queries": [
            "select * where organization = 'Jetport'"
          ],
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Revenue & Tax",
            "Jetport"
          ],
          "visualization": {
            "default_view": "overtime",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2",
                    "render_type": "bullet"
                  }
                ],
                "default_secondary_metric": "Revised Budget"
              }
            },
            "overtime": {
              "default_view": "burn_up",
              "show_area_chart": "true",
              "show_burn_up_chart": "true",
              "show_timeline_total": "true",
              "timeline": {
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ]
              },
              "burn_up": {
                "default_bench_mark": "Revised Budget",
                "default_time_frame": "year_on_year",
                "default_compare_year": "2019",
                "secondary_metric_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "actual",
                    "name": "Actual Revenue",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum",
                    "prefix": "$",
                    "suffix": "",
                    "precision": "2"
                  }
                ],
                "bench_mark_entries": [
                  {
                    "column": "revisedbudget",
                    "name": "Revised Budget",
                    "aggregate_type": "sum"
                  },
                  {
                    "column": "originalbudget",
                    "name": "Original Budget",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          }
        }
      ],
      "leaf_page_entries": [
        {
          "column": "segment2",
          "name": "Function"
        },
        {
          "column": "segment3",
          "name": "Department"
        },
        {
          "column": "fund",
          "name": "Fund"
        },
        {
          "column": "segment4",
          "name": "Division"
        },
        {
          "column": "organization",
          "name": "Organisation"
        },
        {
          "column": "object",
          "name": "Budget Object"
        },
        {
          "column": "charactercodedescription",
          "name": "Character Code"
        },
        {
          "column": "accountdescription",
          "name": "Account Description"
        }
      ],
      "quick_filter_entries": [
        {
          "column": "accounttype",
          "name": "Account Type",
          "renderType": "text"
        }
      ]
    },
    {
      "name": "Payroll & Compensation",
      "dataset_domain": "portlandme.data.socrata.com",
      "dataset_id": "4fix-tsif",
      "fields": {
        "date_column": "checkdate"
      },
      "dimension_entries": [
        {
          "column": "groupbargainingunit",
          "name": "Bargaining Unit"
        },
        {
          "column": "jobclass",
          "name": "Job"
        },
        {
          "column": "position",
          "name": "Position"
        },
        {
          "column": "employeeid",
          "name": "Employee ID"
        },
        {
          "column": "paycategory",
          "name": "Pay Category"
        },
        {
          "column": "paytype",
          "name": "Pay Type"
        }
      ],
      "view_entries": [
        {
          "name": "Total Payroll",
          "column": "payamount",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "0",
          "tags": [
            "Payroll & HR"
          ],
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "paycategory",
                    "name": "Pay Type",
                    "aggregate_type": "",
                    "prefix": "",
                    "suffix": "",
                    "precision": "",
                    "render_type": "stack"
                  }
                ],
                "default_secondary_metric": "Pay Type"
              }
            },
            "overtime": {
              "show_burn_up_chart": "true",
              "timeline": {
                "bench_mark_entries": [
                  {
                    "column": "payamount",
                    "name": "Total payroll",
                    "aggregate_type": "sum"
                  }
                ]
              },
              "burn_up": {
                "bench_mark_entries": [
                  {
                    "column": "payamount",
                    "name": "Total payroll",
                    "aggregate_type": "sum"
                  }
                ]
              }
            }
          }
        },
        {
          "name": "Total Overtime",
          "column": "payamount",
          "aggregate_type": "sum",
          "prefix": "$",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Payroll & HR"
          ],
          "visualization": {
            "default_view": "snapshot"
          },
          "quick_filters": [
            {
              "column": "paycategory",
              "field": "quick_filter_1_4fix-tsif_0",
              "type": "text",
              "values": [
                "OVERTIME"
              ],
              "operator": "="
            }
          ]
        }
      ],
      "leaf_page_entries": [
        {
          "column": "position",
          "name": "Position"
        },
        {
          "column": "jobclass",
          "name": "Job Class"
        },
        {
          "column": "paycategory",
          "name": "Pay Type"
        }
      ],
      "quick_filter_entries": [
        {
          "column": "paycategory",
          "name": "Pay Type",
          "renderType": "text"
        }
      ]
    },
    {
      "name": "Employee Details",
      "dataset_domain": "portlandme.data.socrata.com",
      "dataset_id": "9e9t-jury",
      "fields": {
        "date_column": "last_updated_date"
      },
      "dimension_entries": [
        {
          "column": "department",
          "name": "Department"
        },
        {
          "column": "primaryjobclass",
          "name": "Primary Job Class"
        },
        {
          "column": "primarygroupbargainingunit",
          "name": "Primary Bargaining Unit"
        },
        {
          "column": "primarylocation",
          "name": "Primary Location"
        },
        {
          "column": "personnelstatus",
          "name": "Personnel Status"
        },
        {
          "column": "gender",
          "name": "Gender"
        },
        {
          "column": "fullname",
          "name": "Employee Name"
        }
      ],
      "view_entries": [
        {
          "name": "Headcount",
          "column": "employeeid",
          "parent_queries": [
            "select * where activestatus = 'ACTIVE'"
          ],
          "aggregate_type": "count",
          "prefix": "",
          "suffix": "",
          "precision": "0",
          "tags": [
            "Payroll & HR"
          ],
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart",
              "show_pie_chart": "false",
              "barchart": {
                "secondary_metric_entries": [
                  {
                    "column": "paycategory",
                    "name": "Pay Type",
                    "aggregate_type": "",
                    "prefix": "",
                    "suffix": "",
                    "precision": "",
                    "render_type": "stack"
                  }
                ],
                "default_secondary_metric": "employeeage"
              }
            }
          }
        }
      ],
      "leaf_page_entries": [
        {
          "column": "position",
          "name": "Position"
        },
        {
          "column": "jobclass",
          "name": "Job Class"
        },
        {
          "column": "paycategory",
          "name": "Pay Type"
        }
      ],
      "quick_filter_entries": [
        {
          "column": "paycategory",
          "name": "Pay Type",
          "renderType": "text"
        }
      ]
    },
    {
      "name": "Employee Actions",
      "dataset_domain": "portlandme.data.socrata.com",
      "dataset_id": "89jm-4cm3",
      "fields": {
        "date_column": "effectivedate"
      },
      "dimension_entries": [
        {
          "column": "department",
          "name": "Department"
        },
        {
          "column": "jobclass",
          "name": "Job Class"
        },
        {
          "column": "position",
          "name": "Position"
        },
        {
          "column": "action",
          "name": "Action"
        },
        {
          "column": "reason",
          "name": "Reason"
        }
      ],
      "view_entries": [
        {
          "name": "Internal Transfers",
          "column": "case(isdepartmentchanged = 'True', 1, true, 0)",
          "aggregate_type": "sum",
          "prefix": "",
          "suffix": "",
          "precision": "",
          "tags": [
            "Payroll & HR"
          ],
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart"
            }
          },
          "comparison_column_entries": []
        },
        {
          "name": "Retirements & Resignations",
          "column": "actionhistoryid",
          "aggregate_type": "count",
          "prefix": "",
          "suffix": "",
          "precision": "",
          "tags": [
            "Payroll & HR"
          ],
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart"
            }
          },
          "comparison_column_entries": [],
          "parent_queries": [
            "select * where action like '%RESIGN%'"
          ]
        }
      ],
      "leaf_page_entries": [
        {
          "column": "department",
          "name": "Department"
        },
        {
          "column": "jobclass",
          "name": "Job Class"
        },
        {
          "column": "position",
          "name": "Position"
        },
        {
          "column": "action",
          "name": "Action"
        },
        {
          "column": "reason",
          "name": "Reason"
        },
        {
          "column": "employeename",
          "name": "Employee"
        }
      ]
    },
    {
      "name": "Bids per Opportunity",
      "dataset_domain": "portlandme.data.socrata.com",
      "dataset_id": "c3bq-eivp",
      "parent_queries": [
        "select min(opportunityname) as oppurtunity_name, min(datesubmitted) as date_submitted, min(biddername) as bidder_name, min(requestingdepartment) as requesting_department, count(bidderid) as bidder_count, opportunityid group by opportunityid "
      ],
      "fields": {
        "date_column": "date_submitted"
      },
      "dimension_entries": [
        {
          "column": "oppurtunity_name",
          "name": "Oppurtunity Name"
        },
        {
          "column": "bidder_name",
          "name": "Bidder Name"
        },
        {
          "column": "requesting_department",
          "name": "Requesting Department"
        }
      ],
      "view_entries": [
        {
          "name": "Bids per Opportunity",
          "column": "sum(bidder_count)/count(opportunityid)",
          "aggregate_type": "",
          "prefix": "",
          "suffix": "",
          "precision": "2",
          "tags": [
            "Budget & Expenditures"
          ],
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart"
            }
          },
          "comparison_column_entries": []
        }
      ],
      "leaf_page_entries": [
        {
          "column": "oppurtunity_name",
          "name": "Oppurtunity Name"
        },
        {
          "column": "bidder_name",
          "name": "Bidder Name"
        },
        {
          "column": "requesting_department",
          "name": "Requesting Department"
        }
      ]
    },
    {
      "name": "Applicants per Open Position",
      "dataset_domain": "portlandme.data.socrata.com",
      "dataset_id": "y3ez-h7va",
      "parent_queries": [
        "select min(jobopening) as job_opening, min(city) as city, count(applicantid) as applicant_id, jobopeningrequisitionnumber where applicationdate between {START_DATE} and {END_DATE} group by jobopeningrequisitionnumber"
      ],
      "fields": {
        "date_column": "hire_date"
      },
      "dimension_entries": [
        {
          "column": "job_opening",
          "name": "Job Opening"
        },
        {
          "column": "city",
          "name": "City"
        }
      ],
      "view_entries": [
        {
          "name": "Applicants per Open Position",
          "column": "applicant_id",
          "aggregate_type": "avg",
          "prefix": "",
          "suffix": "applicants",
          "precision": "0",
          "tags": [
            "Payroll & HR"
          ],
          "start_date_override_and_ignore": "true",
          "end_date_override_and_ignore": "true",
          "visualization": {
            "default_view": "snapshot",
            "snapshot": {
              "chart_type": "barChart"
            }
          },
          "comparison_column_entries": []
        }
      ],
      "leaf_page_entries": [
        {
          "column": "job_opening",
          "name": "Job Opening"
        },
        {
          "column": "city",
          "name": "City"
        }
      ]
    }
  ]
}
