import '../models/issue.dart';
import '../theme/tokens.dart';

const mockIssues = <Issue>[
  Issue(
    id: 'i1',
    sev: SevKind.red,
    page: 4,
    title: 'Automatic 12-month renewal',
    snippet:
        'Lease renews for an additional 12-month term unless tenant gives written notice 90 days before expiration.',
    why:
        "You're locked in for another year if you forget to give notice in time.",
    action: 'Add a calendar reminder for Feb 1, 2026 — or negotiate a 30-day window.',
  ),
  Issue(
    id: 'i2',
    sev: SevKind.red,
    page: 7,
    title: 'Landlord may enter with 12-hour notice',
    snippet:
        'Landlord reserves the right to enter the premises with twelve (12) hours notice for inspection or maintenance.',
    why:
        'NY state law typically requires 24 hours. This is shorter than usual.',
    action: 'Ask to raise to 24 hours and limit to business hours.',
  ),
  Issue(
    id: 'i3',
    sev: SevKind.red,
    page: 9,
    title: 'Tenant pays for all repairs over \$50',
    snippet:
        'Tenant shall be responsible for the cost of all repairs in excess of fifty dollars (\$50).',
    why:
        'That threshold is unusually low — a single appliance repair will exceed it.',
    action: 'Push the cap to \$250–500, or have landlord cover appliances and structure.',
  ),
  Issue(
    id: 'i4',
    sev: SevKind.amber,
    page: 3,
    title: 'Late fee: 8% of monthly rent',
    snippet:
        'A late fee equal to eight percent (8%) of the monthly rent will be assessed after the 5th of the month.',
    why: 'Above the typical 5% market range, but legal in NY.',
  ),
  Issue(
    id: 'i5',
    sev: SevKind.amber,
    page: 6,
    title: 'No subletting without consent',
    snippet:
        'Tenant may not sublet or assign the premises without prior written consent of the landlord.',
    why:
        "Standard, but consent is at landlord's sole discretion — push for \"reasonable consent.\"",
  ),
  Issue(
    id: 'i6',
    sev: SevKind.amber,
    page: 8,
    title: 'Security deposit held without interest',
    snippet:
        'The security deposit shall be held in an interest-free account during the tenancy.',
    why:
        'In NYC, deposits on units in 6+ unit buildings must accrue interest.',
  ),
  Issue(
    id: 'i7',
    sev: SevKind.amber,
    page: 10,
    title: 'Pet deposit non-refundable',
    snippet: 'A non-refundable pet fee of \$500 is required at signing.',
    why:
        'Common, but worth confirming this is separate from your security deposit.',
  ),
  Issue(
    id: 'i8',
    sev: SevKind.blue,
    page: 1,
    title: 'Rent: \$3,200/month',
    snippet:
        'Monthly rent of three thousand two hundred dollars (\$3,200), due on the 1st.',
    why: 'Confirmed base rent.',
  ),
  Issue(
    id: 'i9',
    sev: SevKind.blue,
    page: 2,
    title: 'Term: 12 months',
    snippet:
        'The initial term is twelve (12) months commencing June 1, 2026.',
    why: 'Standard one-year lease.',
  ),
  Issue(
    id: 'i10',
    sev: SevKind.blue,
    page: 12,
    title: 'Governing law: New York',
    snippet:
        'This Lease shall be governed by the laws of the State of New York.',
    why: 'Applies if any dispute goes to court.',
  ),
];

Issue? findIssue(String id) {
  for (final i in mockIssues) {
    if (i.id == id) return i;
  }
  return null;
}
