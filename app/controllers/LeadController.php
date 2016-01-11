<?php
use Carbon\Carbon;

class LeadController extends BaseController {

    public function store(){

        $v = Validator::make($data = Input::all(), Lead::$rules);

        if($v->fails())
        {
            return Response::json(array('flash' => 'Something went wrong, try again !'), 500);
        }else{
            $lead = new Lead();
            $user = Sentry::getUser();
            $lead->salutation = Input::get('salutation');
            $lead->first_name = Input::get('first_name');
            $lead->last_name = Input::get('last_name');
            $lead->phone = Input::get('phone');
            $lead->email = Input::get('email');
            $lead->instance = Input::get('instance');
            $lead->address = Input::get('address');
            $lead->address2 = Input::get('address2');
            $lead->description = Input::get('description');
            $lead->status_id = Input::get('status_id');
            $lead->save();
            $lead->users()->attach($user, array('notes' => 'User ini yang mengawali lead ini'));

            return Response::json(array('success' => true, 'flash' => 'New lead has been successfully created !'), 200);
        }
    }

    public function update($id){
        $lead = Lead::findOrFail($id);

        $v = Validator::make($data = Input::except('id'), Lead::$rules);

        if($v->fails())
        {
            return Response::json(array('flash' => 'Something went wrong, try again !'), 500);
        }else{
            $user = Sentry::getUser();
            $lead->salutation = Input::get('salutation');
            $lead->first_name = Input::get('first_name');
            $lead->last_name = Input::get('last_name');
            $lead->phone = Input::get('phone');
            $lead->email = Input::get('email');
            $lead->instance = Input::get('instance');
            $lead->address = Input::get('address');
            $lead->address2 = Input::get('address2');
            $lead->description = Input::get('description');
            $lead->status_id = Input::get('status_id');
            $lead->save();
            $lead->users()->attach($user, array('notes' => 'Merubah data lead'));

            return Response::json(array('success' => true, 'flash' => 'The lead has been successfully updated !'), 200);
        }
    }

    public function destroy($id){
        $lead = Lead::find($id);
        $user = Sentry::getUser();
        $salesman = Sentry::findGroupByName('salesman');
        if ($user->inGroup($salesman) && $lead->users != $user->id) {
            return Response::json(array('flash' => 'ERROR 403 : You are prohibited to remove this lead !'), 403);
        } else {
            $lead->users()->detach();
            $lead->delete();
            return Response::json(array('success' => true, 'flash' => 'The lead has successfully removed !'), 200);
        }
    }

    public function index(){
        return Response::json(Lead::orderBy('created_at', 'DESC')->with('leadstatus', 'users.groups')->get());
    }

    public function show($id){
        $lead = Lead::with('leadstatus', array('users' => function($query)
            {
                $query->orderBy('created_at', 'desc');
            }))->findOrFail($id);
        return Response::json($lead);
    }

    public function leadstatuses(){
        return Response::json(Leadstatus::all(), 200);
    }

    public function leadsPerMonth(){
        $range = Carbon::now()->subYears(1);
        $leads = DB::table('leads')
            ->where('created_at', '>=', $range)
            ->groupBy('month')
            ->orderBy('month','desc')
            ->take(12)
            ->get([
                DB::raw('DATE_FORMAT(created_at, "%b %Y") as month'),
                DB::raw('COUNT(*) as value')
                ]);

        $months = [];
        $values = [];
        foreach ($leads as $lead) {
            array_push($months, $lead->month);
            array_push($values, $lead->value);
        }

        return Response::json(array('months' => $months, 'values' => $values), 200);
    }

    public function leadsByUsers(){
        $leads = DB::table('logs_leads')
            ->join('leads', 'leads.id', '=', 'logs_leads.lead_id')
            ->join('users', 'users.id', '=', 'logs_leads.user_id')
            ->groupBy('name')
            ->orderBy('name','asc')
            ->get([
                DB::raw('CONCAT(users.first_name, IFNULL(CONCAT(" ", users.last_name), "")) as name'),
                DB::raw('COUNT(*) as value')
                ]);

        $users = [];
        $values = [];
        foreach ($leads as $lead) {
            array_push($users, $lead->name);
            array_push($values, $lead->value);
        }

        return Response::json(array('users' => $users, 'values' => $values), 200);
    }

    public function leadsByUser(){
        $range = Carbon::now()->subYears(1);
        $user = Sentry::getUser();
        $leads = DB::table('logs_leads')
            ->where('leads.created_at', '>=', $range)
            ->join('leads', 'leads.id', '=', 'logs_leads.lead_id')
            ->join('users', 'users.id', '=', 'logs_leads.user_id')
            ->where('users.id', '=', $user->id)
            ->groupBy('month')
            ->orderBy('month','desc')
            ->take(12)
            ->get([
                DB::raw('DATE_FORMAT(leads.created_at, "%b %Y") as month'),
                DB::raw('COUNT(*) as value')
                ]);

        $months = [];
        $values = [];
        foreach ($leads as $lead) {
            array_push($months, $lead->month);
            array_push($values, $lead->value);
        }

        return Response::json(array('months' => $months, 'values' => $values), 200);
    }


}
