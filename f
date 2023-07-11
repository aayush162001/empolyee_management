
[1mFrom:[0m /home/thinkbiz/emp/app/controllers/users_controller.rb:29 UsersController#update:

    [1;34m23[0m: [32mdef[0m [1;34mupdate[0m        
    [1;34m24[0m:     [1;34m# binding.pry[0m
    [1;34m25[0m:     [1;34m# @users = User.find(params[:id])[0m
    [1;34m26[0m:     [32mif[0m current_user.company_admin? || current_user.super_admin?    
    [1;34m27[0m: 
    [1;34m28[0m:         [32mif[0m @users.update(user_params)
 => [1;34m29[0m:             binding.pry
    [1;34m30[0m:             redirect_to users_url, [35mnotice[0m: [31m[1;31m"[0m[31mUser was successfully update[1;31m"[0m[31m[0m
    [1;34m31[0m:         [32melse[0m
    [1;34m32[0m:             render [33m:edit[0m, [35mstatus[0m: [33m:unprocessable_entity[0m
    [1;34m33[0m:         [32mend[0m
    [1;34m34[0m:     
    [1;34m35[0m:     [32melsif[0m current_user.id == params[[33m:id[0m]
    [1;34m36[0m:         binding.pry
    [1;34m37[0m:         [32mif[0m @users.update(user_params)
    [1;34m38[0m:             binding.pry
    [1;34m39[0m:             redirect_to root_path, [35mnotice[0m: [31m[1;31m"[0m[31mYou update was added successfully.[1;31m"[0m[31m[0m
    [1;34m40[0m:         [32melse[0m
    [1;34m41[0m:             render [33m:edit[0m, [35mstatus[0m: [33m:unprocessable_entity[0m
    [1;34m42[0m:         [32mend[0m
    [1;34m43[0m:     [32melse[0m 
    [1;34m44[0m:         render [33m:edit[0m, [35mstatus[0m: [33m:unprocessable_entity[0m
    [1;34m45[0m:     [32mend[0m
    [1;34m46[0m: [32mend[0m

